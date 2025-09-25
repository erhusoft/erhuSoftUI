# erhuSoftUI

Biblioteca de componentes UI para Swift, compatible con iOS y macOS.

## Descripción
`erhuSoftUI` es un paquete Swift que proporciona una colección de componentes visuales reutilizables para aplicaciones iOS y macOS. Incluye botones, campos de texto, tarjetas, selectores, grids de datos, imágenes, modificadores y utilidades de formato.

## Instalación
Agrega el paquete a tu proyecto Swift Package Manager:

```swift
.package(url: "<URL del repositorio>", from: "1.0.0")
```

## Uso básico
Importa el módulo en tu archivo Swift:

```swift
import erhuSoftUI
```

Ejemplo de uso de un botón:
```swift
ESButton(title: "Aceptar", action: { /* acción */ })
```

## Estructura del proyecto
- **Sources/erhuSoftUI/**: Componentes principales
  - ESButton, ESDataGrid, ESFormatUtils, ESImage, ESModifier, ESNavLink, ESPicker, ESStepperButton, ESTag, ESTextField, ESToast
- **Tests/erhuSoftUITests/**: Pruebas unitarias

## Documentación técnica
La documentación detallada de cada componente se encuentra en los comentarios del código fuente y puede ser generada automáticamente con DocC.

## Licencia
[MIT](LICENSE)
