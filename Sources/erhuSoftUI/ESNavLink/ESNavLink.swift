//
//  ESNavLink.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
//  Componente SwiftUI para navegación tipo enlace visual.
//  Permite navegar a una vista destino con estilo de botón y soporte de icono.
//


import SwiftUI

/// Componente de navegación tipo enlace visual.
/// Permite navegar a una vista destino con estilo de botón, icono opcional y altura configurable.
/// - Parameters:
///   - title: Título a mostrar en el enlace.
///   - destination: Vista destino a navegar.
///   - icon: Nombre del SF Symbol opcional.
///   - height: Altura mínima del enlace (por defecto 44).
public struct ESNavLink<Destination: View>: View {
    @Environment(\.colorScheme) private var scheme
    /// Título a mostrar en el enlace.
    public var title: String
    /// Vista destino a navegar.
    public var destination: Destination
    /// Nombre del SF Symbol opcional.
    public var icon: String?        // 👈 opcional
    /// Altura mínima del enlace.
    public var height: CGFloat      // 👈 configurable
    /// Inicializa un enlace de navegación visual.
    /// - Parameters:
    ///   - title: Título del enlace.
    ///   - destination: Vista destino.
    ///   - icon: Nombre del SF Symbol opcional.
    ///   - height: Altura mínima (por defecto 44).
    public init(
        title: String,
        destination: Destination,
        icon: String? = nil,
        height: CGFloat = 44
    ) {
        self.title = title
        self.destination = destination
        self.icon = icon
        self.height = height
    }
    /// Vista principal del enlace de navegación.
    public var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.textPrimary)
                }
                Text(title)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color.textPrimary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: height)
            .background(Color.card)
            .cornerRadius(8)
            .contentShape(Rectangle()) // área clickeable completa
        }
        .buttonStyle(.plain)
    }
}
