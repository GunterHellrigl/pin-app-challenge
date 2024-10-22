# PinApp Challenge - Flutter developer with iOS knowledge

Esta aplicación Flutter permite visualizar una lista de posts y al hacer tap en uno de ellos, ver los comentarios asociados a ese post. El proyecto fue diseñado para ejecutar la aplicación en iOS usando una integración de código nativo. Los posts se obtienen desde un endpoint externo y los comentarios de una integración nativa a través de un plugin hecho en Swift.

## Instalación

### Clonar el repositorio
Clona este repositorio en tu máquina local usando el siguiente comando:

```bash
git clone https://github.com/usuario/repo.git
```

### Instalación de dependencias
Una vez clonado el proyecto, abre con Visual Studio Code y ejecuta Pub Get o desde la consola en el directorio ejecuta el comando 

```bash
flutter pub get
```

### Ejecutar en iOS
En Visual Studio Code puedes ejecutar desde 

<img width="344" alt="image" src="https://github.com/user-attachments/assets/53ff40d6-ff3f-4708-acff-7b9ae23a4a55">


## Datos técnicos

### Arquitectura
Se decidió usar como arquitectura **Clean Architecture** pensando en un enfoque **mantenible**, **escalable** y **testeable fácilmente**. Se separó en las siguientes capas:
- **Dominio**: Acá se encuentra la lógica de negocio, y el estado más puro de las entidades. Estas se comunican con interfaces de repositories que luego las consumen los Blocs.
- **Data**: Acá se encuentran las implementaciones de los repositories que se encargan de cómo gestionar el acceso a los datos (local, remoto, cache, etc). Estos a su vez dependen de los **datasources** que son aquellos que realmente acceden a los datos. Un repository puede concentrar la lógica de usar distintos tipos de datasources y combinar una lógica compleja según sea el caso.
- **presentation**: Acá se encuentran las vistas así como el método para gestionar los estados en Flutter. Estos tienen acceso al dominio de la aplicación pero no a los datos, es decir, tienen acceso a que tienen **que hacer** pero no saben **como lo hacen**. 

#### Ventajas de la arquitectura
- Si mañana queremos cambiar la forma de obtener datos, solo se modifica una capa y el resto de la aplicación sigue igual.
- Si queremos cambiar el gestor de estados en Flutter, se modifica la presentación, pero las capas de dominio y data siguen intactas.
- Podemos tener código tan desacoplado que nos da la ventaja de hacer test unitarios sin problemas.

### Integración Nativa con Swift
Se realizó una integración nativa en Swift (iOS) a Flutter a través de un plugin. El plugin es totalmente independiente del proyecto principal y se importa usando 
```yaml
dependencies:
  pin_app_challenge_post_sdk:
    path: ../pin_app_challenge_post_sdk # Path de donde se ubica el proyecto
```
y luego en Flutter se usa de la siguiente forma:
```dart
final PinAppChallengePostSdk sdk;
final comments = await sdk.getComments(postId);
```

### Dependencias
- go_router: Para manejar y organizar las rutas en toda la aplicación.
- freezed / freezed_annotation / json_annotation: Para la autogeneración de modelos y evitar mucho boilerplate.
- http: Para consumir peticiones HTTP.
- either_dart: Para manejo de errores y uso de left y right en un solo tipo (railway oriented programming).
- get_it: Librería para inyección de dependencias.
- flutter_bloc: Para manejar los estados en Flutter usando el patrón Bloc.
- pin_app_challenge_post_sdk: Plugin nativo creado con Swift para consumir la lista de comentarios de un post.
- mockito: Usado para mockear clases y poder testearlas.

## Agradecimientos
Gracias por la oportunidad de poder realizar este challenge, espero que sea de su agrado y por favor, necesito un feedback de todo lo realizado para poder mejorar cada día más. Saludos!
