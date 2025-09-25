# ``erhuSoftUI``

Biblioteca de componentes UI para Swift, compatible con iOS y macOS.

## Descripción
`erhuSoftUI` es un paquete Swift que proporciona una colección de componentes visuales reutilizables para aplicaciones iOS y macOS. Incluye botones, campos de texto, tarjetas, selectores, grids de datos, imágenes, modificadores y utilidades de formato.

## Instalación
Agrega el paquete a tu proyecto Swift Package Manager:

```swift
.package(url: "https://github.com/erhusoft/erhuSoftUI.git", from: "1.0.0")
```

## Ejemplo de uso
```swift
import erhuSoftUI

ESButton(title: "Aceptar", action: { /* acción */ })
```

## Componentes principales
- ``ESButton``
- ``ESDataGridView``
- ``ESTextField``
- ``ESToastManager``
- ``ESImage``
- ``ESMenuPicker``
- ``StepperButton``
- ``ESTag``
- ``ESNavLink``
- ``ESFormatUtils``
- ``ESSizeModifier``

## Generar documentación localmente
Puedes generar y visualizar la documentación con Xcode o usando el comando:

```sh
xcodebuild docbuild -scheme erhuSoftUI
```

## Licencia
[MIT](../../../../LICENSE)
