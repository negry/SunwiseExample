//
//  MT+HttpService.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation

enum MTServiceError: Error {
    case requestFailed
    case badRequest(data: Data?)
    case unknownError(data: Data?)
    case urlRequestCreationFailed(errorMessage: String)
    case dataSerializerError(errorMessage: String)
    case unauthorized(data: Data?)
}

enum MTServiceResponseCode: Int
{
    case OK = 200
    case CREATED = 201
    case BAD_REQUEST = 404
    case UNAUTHORIZED = 401
    case SERVER_ERROR = 500
}

typealias MTServiceResult<T: Codable> = Result<T, MTServiceError>
typealias MTServiceGenericResult<T: Codable> = (Result<T, MTServiceError>) -> Void

class MTService {
    
    class func genericRequest<T: Codable>(router: MTRouter, body: Data? = nil, completion: @escaping MTServiceGenericResult<T>) {

        if let urlRequest = self.createUrlRequest(withRouter: router, andBody: body){
            
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in

                if let serverError = error {
                    completion(.failure(.urlRequestCreationFailed(errorMessage: serverError.localizedDescription)))
                }else {
                    guard let httpResponse =  response as? HTTPURLResponse else { return }
                    guard let data = data else { return }
                    print("Code response: \(httpResponse.statusCode)")
                    switch httpResponse.statusCode {
                    
                    case MTServiceResponseCode.OK.rawValue, MTServiceResponseCode.CREATED.rawValue:
                        self.handleSuccessResponse(data: data, completion: completion)
                        
                    case MTServiceResponseCode.UNAUTHORIZED.rawValue:
                        completion(.failure(.unauthorized(data: data)))
                        
                    case MTServiceResponseCode.BAD_REQUEST.rawValue:
                        completion(.failure(.badRequest(data: data)))
                        
                    default:
                        completion(.failure(.unknownError(data: data)))
                    }
                }

            }
            dataTask.resume()
        }else {
            completion(.failure(.urlRequestCreationFailed(errorMessage: "request creation failed")))
        }
    }
    
    private class func handleSuccessResponse<T: Codable>(data: Data, completion: @escaping MTServiceGenericResult<T>)
    {
        do {
            let jsonResponse: T = try JSONDecoder().decode(T.self, from: data)
            completion(.success(jsonResponse))
        }catch let error {
            print(error)
            completion(.failure(.dataSerializerError(errorMessage: error.localizedDescription)))
        }
    }
    
    private class func createUrlRequest(withRouter router: MTRouter, andBody body: Data?) -> URLRequest?
    {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        if let routerPort = router.port {
            components.port = routerPort
        }
        components.path = router.path
        let queryParams = router.parameters
        
        if !queryParams.isEmpty {
            components.queryItems = queryParams
        }
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        urlRequest.allHTTPHeaderFields = router.headers
        if let body = body {
            urlRequest.httpBody = body
        }
        print("Request to: \(urlRequest.url!.absoluteString)")
        return urlRequest
    }
}
