//
//  ESTag.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

/// Componente de etiqueta visual (tag) para SwiftUI.
///
/// Permite mostrar texto y/o ícono (SF Symbol o asset) con color y estilo personalizable.
/// Ideal para estados, categorías, etiquetas y resúmenes visuales.
///
/// Ejemplo de uso:
/// ```swift
/// ESTag(text: "Cancelado", color: .red)
/// ESTag(text: "Favorito", systemIcon: "heart.fill", tint: .pink, color: .pink)
/// ESTag(text: "SwiftUI", assetIcon: "stars", color: .blue)
/// ESTag(systemIcon: "bolt.fill", tint: .yellow, color: .yellow)
/// ```
public struct ESTag: View {
    /// Texto a mostrar en la etiqueta.
    public var text: String?
    /// Ícono SF Symbol a mostrar (opcional).
    public var systemIcon: String?
    /// Ícono de asset a mostrar (opcional).
    public var assetIcon: String?
    /// Color de tinte para el ícono (opcional).
    public var tint: Color? = nil
    /// Color principal de la etiqueta.
    public var color: Color
    /// Tamaño de la fuente del texto.
    public var fontSize: CGFloat = 12
    /// Tamaño del ícono.
    public var iconSize: CGFloat = 12
    
    /// Inicializa una etiqueta visual.
    /// - Parameters:
    ///   - text: Texto de la etiqueta.
    ///   - systemIcon: Ícono SF Symbol (opcional).
    ///   - assetIcon: Ícono asset (opcional).
    ///   - tint: Color de tinte para el ícono.
    ///   - color: Color principal de la etiqueta.
    ///   - fontSize: Tamaño de la fuente.
    ///   - iconSize: Tamaño del ícono.
    public init(
        text: String? = nil,
        systemIcon: String? = nil,
        assetIcon: String? = nil,
        tint: Color? = nil,
        color: Color = .blue,
        fontSize: CGFloat = 12,
        iconSize: CGFloat = 12
    ) {
        self.text = text
        self.systemIcon = systemIcon
        self.assetIcon = assetIcon
        self.tint = tint
        self.color = color
        self.fontSize = fontSize
        self.iconSize = iconSize
    }
    
    public var body: some View {
        HStack(spacing: shouldShowBoth ? 6 : 0) {
            if let assetIcon {
                Image(assetIcon)
                    .resizable()
                    .renderingMode(tint == nil ? .original : .template)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(tint)
            }
            
            if let systemIcon {
                Image(systemName: systemIcon)
                    .resizable()
                    .renderingMode(tint == nil ? .original : .template)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(tint)
            }
            
            if let text {
                Text(text)
                    .font(.system(size: fontSize, weight: .light))
                    .foregroundColor(color)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(color.opacity(0.1))
        )
    }
    
    private var shouldShowBoth: Bool {
        let hasIcon = systemIcon != nil || assetIcon != nil
        return hasIcon && text != nil
    }
    
    private var horizontalPadding: CGFloat {
        let hasIcon = systemIcon != nil || assetIcon != nil
        if hasIcon && text != nil { return 12 }
        return 8
    }
}

#Preview("Tags Light") {
    VStack(spacing: 10) {
        ESTag(text: "Cancelado", color: .red)
        ESTag(text: "Aceptado", color: .green)
        ESTag(text: "Favorito", systemIcon: "heart.fill", tint: .pink, color: .pink)
        ESTag(text: "SwiftUI", assetIcon: "stars", color: .blue)
        ESTag(systemIcon: "bolt.fill", tint: .yellow, color: .yellow)
    }
    .padding()
    .background(Color.bg)
}

#Preview("Tags Dark") {
    VStack(spacing: 10) {
        ESTag(text: "Cancelado", color: .red)
        ESTag(text: "Aceptado", color: .green)
        ESTag(text: "Favorito", systemIcon: "heart.fill", tint: .pink, color: .pink)
        ESTag(text: "SwiftUI", assetIcon: "stars", color: .blue)
        ESTag(systemIcon: "heart.fill", tint: .red, color: .white)
    }
    .padding()
    .background(Color.bg)
}
