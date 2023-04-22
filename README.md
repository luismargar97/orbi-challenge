### Orbi challenge
Una vez descargado el proyecto es necesario hacer `flutter pub get` para descargar los paquetes necesarios. 
En caso de error al construir dejo las versiones que `flutter doctor` arrojo

- [✓] Flutter (Channel stable, 3.3.7, on macOS 13.3.1 22E261 darwin-arm (Rosetta), locale en-MX)
- [✓] Android toolchain - develop for Android devices (Android SDK version 33.0.2)
- [✓] Xcode - develop for iOS and macOS (Xcode 14.2)
- [✓] Chrome - develop for the web
- [✓] Android Studio (version 2022.1)
- [✓] VS Code (version 1.77.3)
- [✓] Connected device (3 available)
- [✓] HTTP Host Availability

## Getting Started:
A continuacion se explica la estructura del proyecto, en la carpeta `lib` se tendrán 6 carpetas:

- blog = lógica de negocio dirigido a cada provider.
- models = modelos/clases usadas para convertir de json a objeto reconocido por flutter, además de que se agregan métodos que resuelven cierto problema.
- providers = proveedores de información remoto y local, información obtenida de PokeAPI y local storage respectivamente.
- routes = vistas de la aplicación.
- utils = herramientas que se utilizan a lo largo de la app.
- widgets = widgets utilizados en toda la aplicación, son aquellos que se usan en diferentes vistas.

## Bonus:
- Ordenación de pokemons como se fue requerido en el apartado opcional.
- Icon app
- Splash screen

https://user-images.githubusercontent.com/124298061/233803585-14b17ba7-3c29-4e91-ad35-a40464fde0c4.mov

