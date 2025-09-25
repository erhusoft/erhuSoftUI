//
//  ESButton.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

/// Tipos de estilo disponibles para ESButton.
///
/// - horizontal: Ícono y texto en línea.
/// - vertical: Ícono arriba, texto abajo.
/// - fixedGrid: Botón cuadrícula con tamaño fijo.
/// - fullWidth: Botón que ocupa todo el ancho.
/// - tag: Botón tipo etiqueta.
/// - custom: Botón con tamaño personalizado.
/// - icon: Solo ícono, tamaño configurable.
public enum ESButtonStyleType {
    case horizontal
    case vertical
    case fixedGrid(width: CGFloat = 90, height: CGFloat = 70)
    case fullWidth
    case tag
    case custom(width: CGFloat?, height: CGFloat?)
    case icon(size: CGFloat = 24) // 👈 NUEVO
}

/// Un botón personalizable para interfaces SwiftUI.
///
/// Permite mostrar texto, ícono y elegir entre varios estilos visuales. Ideal para acciones principales, secundarias o icon-only.
///
/// Ejemplo de uso:
/// ```swift
/// ESButton(title: "Aceptar", icon: "checkmark", color: .green, style: .horizontal) {
///     print("Botón presionado")
/// }
/// ```
public struct ESButton: View {
    @Environment(\.colorScheme) private var scheme
    
    public var title: String
    public var icon: String?
    public var color: Color
    public var style: ESButtonStyleType
    public var action: (() -> Void)?
    
    /// Inicializa un botón personalizado.
    /// - Parameters:
    ///   - title: Texto del botón.
    ///   - icon: Nombre del ícono SF Symbol (opcional).
    ///   - color: Color principal del botón.
    ///   - style: Estilo visual del botón (ver ESButtonStyleType).
    ///   - action: Acción a ejecutar al presionar el botón.
    public init(
        title: String = "",
        icon: String? = nil,
        color: Color = .blue,
        style: ESButtonStyleType = .horizontal,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.color = color
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            content
                .padding(8)
                .frame(maxWidth: {
                    switch style {
                    case .fullWidth: return .infinity
                    default: return nil
                    }
                }())
                .frame(width: frameWidth, height: frameHeight)
                .background(backgroundView)
                .cornerRadius(6)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Content
    /// Contenido del botón según el estilo seleccionado.
    /// - Nota: El diseño varía según el valor de `style`.
    @ViewBuilder
    private var content: some View {
        switch style {
        case .horizontal:
            HStack(spacing: 6) { iconView(fontSize: 16); textView }
        case .vertical:
            VStack(spacing: 6) { iconView(fontSize: 16); textView }
        case .fullWidth:
            textView.frame(maxWidth: .infinity)
        case .fixedGrid:
            VStack { iconView(fontSize: 22); textView }
        case .tag:
            HStack { iconView(fontSize: 10); textView }
        case .custom:
            HStack { iconView(fontSize: 14); textView }
        case .icon(let size):
            iconView(fontSize: size) // 👈 solo icono
        }
    }
    
    // MARK: - Icon
    /// Vista del ícono, si se proporciona uno.
    /// - Parameter fontSize: Tamaño del ícono.
    @ViewBuilder
    private func iconView(fontSize: CGFloat) -> some View {
        if let icon {
            #if os(macOS)
            if let image = NSImage(named: icon) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: fontSize, height: fontSize)
                    .foregroundColor(color)
            } else {
                Image(systemName: icon)
                    .font(.system(size: fontSize))
                    .foregroundColor(color)
            }
            #else
            if UIImage(named: icon) != nil {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: fontSize, height: fontSize)
                    .foregroundColor(color)
            } else {
                Image(systemName: icon)
                    .font(.system(size: fontSize))
                    .foregroundColor(color)
            }
            #endif
        }
    }
    
    // MARK: - Text
    /// Vista del texto del botón.
    private var textView: some View {
        Text(title)
            .font(.system(size: 14, weight: .light))
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
    
    // MARK: - Frame
    /// Calcula el ancho del botón según el estilo.
    private var frameWidth: CGFloat? {
        switch style {
        case .fixedGrid(let width, _): return width
        case .custom(let width, _): return width
        default: return nil
        }
    }
    
    private var frameHeight: CGFloat? {
        switch style {
        case .fixedGrid(_, let height): return height
        case .tag: return 20
        case .custom(_, let height): return height
        default: return nil
        }
    }
    
    // MARK: - Background
    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .fixedGrid:
            Color.grid
        case .horizontal, .vertical, .tag, .custom, .icon:
            color.opacity(0.2)
        case .fullWidth:
            Color.row
        }
    }
}
