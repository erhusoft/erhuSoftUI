//
//  ESImage.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
//  Componente SwiftUI para mostrar imágenes desde diferentes fuentes (URL, SF Symbol, asset).
//  Permite aplicar recorte, tamaño y color opcional al icono.
//

import SwiftUI

/// Vista de imagen flexible para mostrar imágenes desde URL, SF Symbol o asset.
/// Permite aplicar recorte, tamaño y color opcional al icono.
/// - Parameters:
///   - url: URL de la imagen remota (opcional).
///   - systemName: Nombre del SF Symbol (opcional).
///   - assetName: Nombre del asset local (opcional).
///   - size: Tamaño de la imagen (ancho y alto).
///   - clipShape: Forma de recorte (Shape).
///   - tint: Color opcional para el icono SF Symbol.
public struct ESImage<Clip: Shape>: View {
    /// URL de la imagen remota (opcional).
    public var url: String?
    /// Nombre del SF Symbol (opcional).
    public var systemName: String?
    /// Nombre del asset local (opcional).
    public var assetName: String?
    /// Tamaño de la imagen (ancho y alto).
    public var size: CGFloat
    /// Forma de recorte (Shape).
    public var clipShape: Clip
    /// Color opcional para el icono SF Symbol.
    public var tint: Color?    // 👈 opcional: aplicar color al icono

    /// Inicializa una vista ESImage.
    /// - Parameters:
    ///   - url: URL de la imagen remota (opcional).
    ///   - systemName: Nombre del SF Symbol (opcional).
    ///   - assetName: Nombre del asset local (opcional).
    ///   - size: Tamaño de la imagen.
    ///   - clipShape: Forma de recorte.
    ///   - tint: Color opcional para el icono SF Symbol.
    public init(
        url: String? = nil,
        systemName: String? = nil,
        assetName: String? = nil,
        size: CGFloat,
        clipShape: Clip,
        tint: Color? = nil
    ) {
        self.url = url
        self.systemName = systemName
        self.assetName = assetName
        self.size = size
        self.clipShape = clipShape
        self.tint = tint
    }

    /// Vista principal que selecciona la fuente de la imagen y aplica recorte y color.
    public var body: some View {
        Group {
            if let systemName {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .applyTint(tint)
            } else if let assetName {
                Image(assetName)
                    .resizable()
                    .scaledToFit()
            } else if let url, let imageURL = URL(string: url) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .applyTint(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .applyTint(.gray)
            }
        }
        .frame(width: size, height: size)
        .clipShape(clipShape)
    }
}

// MARK: - Helper para tint opcional
/// Extensión privada para aplicar color opcional a una vista.
private extension View {
    /// Aplica un color de tinte si está presente.
    /// - Parameter color: Color opcional.
    /// - Returns: Vista con color aplicado si existe, o la vista original.
    @ViewBuilder
    func applyTint(_ color: Color?) -> some View {
        if let color {
            self.foregroundColor(color)
        } else {
            self
        }
    }
}
