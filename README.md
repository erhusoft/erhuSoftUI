# erhuSoftUI

Biblioteca de componentes UI para Swift, compatible con iOS y macOS.

## Descripción

`erhuSoftUI` es un paquete Swift que proporciona una colección de componentes visuales reutilizables para aplicaciones iOS y macOS. Incluye botones, campos de texto, tarjetas, selectores, grids de datos, imágenes, modificadores, utilidades de formato, tags, toasts y sistema de temas.


## Instalación
Agrega el paquete a tu proyecto Swift Package Manager:

```swift
.package(url: "https://github.com/erhusoft/erhuSoftUI", from: "1.0.0")
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


Ejemplo de grid de datos:
```swift
ESDataGridView(columns: ["Nombre", "Edad"], rows: [["Ana", "23"], ["Luis", "31"]])
```

Ejemplo de imagen:
```swift
ESImage(systemName: "star.fill", size: 40, clipShape: Circle())
```

Ejemplo de toast:
```swift
ESToastManager.shared.showToast(text: "Guardado correctamente", type: .success)
```

## Componentes principales
- **ESButton**: Botón personalizable.
- **ESDataGridView**: Grid de datos tipo tabla.
- **ESUtils**: Utilidades de formato (fechas, números, etc).
- **ESImage**: Vista de imagen flexible (URL, SF Symbol, asset).
- **ESNavLink**: Navegación tipo enlace.
- **ESPicker**: Selector de opciones.
- **ESStepperButton / ESPickerStepper**: Botones y controles tipo stepper.
- **ESTag**: Etiquetas visuales.
- **ESTextField**: Campo de texto personalizado.
- **ESToastManager**: Sistema de notificaciones tipo toast.
- **ThemeManager**: Gestión de temas y colores.

## Assets y temas
- **Media.xcassets**: Paleta de colores y assets visuales para consistencia en UI.
- **ThemeManager.swift**: Permite cambiar el tema de la app (claro/oscuro/personalizado).

## Pruebas unitarias
Las pruebas se encuentran en `Tests/erhuSoftUITests/`. Ejecuta las pruebas con Xcode o `swift test`.

## Documentación técnica
La documentación detallada de cada componente se encuentra en los comentarios del código fuente y puede ser generada automáticamente con DocC. Para consultar la documentación generada:

1. Abre el proyecto en Xcode.
2. Selecciona el esquema del paquete.
3. Ve a Product > Build Documentation.

## Estructura del proyecto
- **Sources/erhuSoftUI/**: Componentes principales
  - ESButton, ESDataGrid, ESFormatUtils, ESImage, ESModifier, ESNavLink, ESPicker, ESStepperButton, ESTag, ESTextField, ESToast
- **Tests/erhuSoftUITests/**: Pruebas unitarias



## Licencia
[MIT](LICENSE)
