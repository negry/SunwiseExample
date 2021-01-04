# Movie Trailer Example App.md

![](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png)


### Requerimientos
                
----
- Xcode 11+


------------


### Ejecución del proyecto
                
----

1. Una vez descargado el repositorio necesitas entrar a la carpeta: `Movie Trailer App` --> Hacer click en el archivo `Movie Trailer App.xcodeproj` para abrir el proyecto
2. Despues de que Xcode se ejecute con el proyecto hacer click en Run que esta en la parte superior izquierda del mismo.



### Notas

- Lo único que guardo en local son las primeras 5 imágenes de las upcomming movies, esto pues porque no me dio mas tiempo para hacer algo de lógica agregada.
- Se utilizo Swift PM (Pude utilizar cocoapod pero me parece que el proyecto se haría mas grande)
- Solo hice 1 test case (login happy & sad paths)
- El inicio de sesión es guardado con UserDefaults (no había requermientos así que solo lo uso para guardar el email ingresado)
- Para iniciar sesión es necesario el email: negryhtc@gmail.com y el pass: 123456
- Se dejo en orientación portrait
- Se uso Realm para almacenar las primeras 5 imagenes en el top de la vista de las pelculas. (No se implemento ninguna logica mas)
- Faltaron ajustes de size class para version en iPad y unos detalles mas en cuanto a diseño
- La vista de las upcomming la deje estatica, es decir, la pude agregar como header de toda la tabla para que hiciera scroll junto con las secciones de populares y top rated
- No implemente paginación por cuestiones de tiempo, pero las funciones asíncronas tienen soporte para paginación y son genericas
- Use MVP Architecture y multi threading para descarga de imagenes y llamadas a API
- URLSession para API calls
