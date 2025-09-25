//
//  ESPicker.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
//  Componente SwiftUI para crear selectores visuales tipo menú y segmentado.
//  Permite seleccionar opciones de forma intuitiva y personalizable.
//

import SwiftUI

/// Selector tipo menú desplegable con opciones personalizables.
/// Permite mostrar una lista de opciones y seleccionar una.
/// - Parameters:
///   - selection: Binding a la opción seleccionada (opcional).
///   - options: Array de opciones disponibles.
///   - label: Vista para mostrar cada opción.
///   - placeholder: Texto a mostrar cuando no hay selección.
///   - icon: Icono SF Symbol opcional.
///   - width: Ancho del selector (opcional).
public struct ESMenuPicker<T: Hashable, Content: View>: View {
    @Environment(\.colorScheme) private var scheme
    /// Opción seleccionada (enlazado, opcional).
    @Binding var selection: T?
    /// Opciones disponibles.
    let options: [T]
    /// Vista para mostrar cada opción.
    let label: (T) -> Content
    /// Texto a mostrar cuando no hay selección.
    let placeholder: String
    /// Icono SF Symbol opcional.
    let icon: String?
    /// Ancho del selector (opcional).
    var width: CGFloat? = nil
    /// Inicializa un menú selector.
    /// - Parameters:
    ///   - selection: Binding a la opción seleccionada.
    ///   - options: Array de opciones.
    ///   - label: Vista para cada opción.
    ///   - placeholder: Texto cuando no hay selección.
    ///   - icon: Icono SF Symbol opcional.
    ///   - width: Ancho opcional.
    public init(
        selection: Binding<T?>,
        options: [T],
        label: @escaping (T) -> Content,
        placeholder: String,
        icon: String? = nil,
        width: CGFloat? = nil
    ) {
        self._selection = selection
        self.options = options
        self.label = label
        self.placeholder = placeholder
        self.icon = icon
        self.width = width
    }
    /// Vista principal del menú selector.
    public var body: some View {
        Menu {
            ForEach(options, id: \.self) { item in
                Button {
                    selection = item
                } label: {
                    label(item)
                }
            }
        } label: {
            HStack(spacing: 6) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundColor(.gray)
                }
                Group {
                    if let selection {
                        label(selection)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    } else {
                        Text(placeholder)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.bar)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.border, lineWidth: 0.6)
            )
            .frame(width: width)
        }
        .buttonStyle(.plain)
    }
}

/// Selector tipo segmentado horizontal.
/// Permite seleccionar una opción entre varias, mostrando el estado visual de selección.
/// - Parameters:
///   - selection: Binding a la opción seleccionada.
///   - options: Array de opciones disponibles.
///   - label: Vista para mostrar cada opción.
///   - width: Ancho del selector (opcional).
public struct ESSegmentedPicker<T: Hashable, Content: View>: View {
    @Environment(\.colorScheme) private var scheme
    /// Opción seleccionada (enlazado).
    @Binding var selection: T
    /// Opciones disponibles.
    let options: [T]
    /// Vista para mostrar cada opción.
    let label: (T) -> Content
    /// Ancho del selector (opcional).
    var width: CGFloat? = nil
    /// Inicializa un selector segmentado.
    /// - Parameters:
    ///   - selection: Binding a la opción seleccionada.
    ///   - options: Array de opciones.
    ///   - label: Vista para cada opción.
    ///   - width: Ancho opcional.
    public init(
        selection: Binding<T>,
        options: [T],
        label: @escaping (T) -> Content,
        width: CGFloat? = nil
    ) {
        self._selection = selection
        self.options = options
        self.label = label
        self.width = width
    }
    /// Vista principal del selector segmentado.
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { item in
                Button {
                    selection = item
                } label: {
                    label(item)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selection == item
                                      ? Color.selection
                                      : Color.clear)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.bar)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.border, lineWidth: 0.6)
        )
        .frame(width: width)
    }
}

// MARK: - Preview
#Preview("Pickers Light") {
   
    VStack(spacing: 20) {
        ESMenuPicker(
            selection: .constant(nil),
            options: ["Opción 1", "Opción 2", "Opción 3"],
            label: { Text($0) },
            placeholder: "Elige una opción",
            icon: "list.bullet.rectangle",
            width: 250
        )
        
        ESSegmentedPicker(
            selection: .constant("Opción 1"),
            options: ["Opción 1", "Opción 2", "Opción 3"],
            label: { Text($0) },
            width: 250
        )
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}

#Preview("Pickers Dark") {
    VStack(spacing: 20) {
        ESMenuPicker(
            selection: .constant("Opción 2"),
            options: ["Opción 1", "Opción 2", "Opción 3"],
            label: { Text($0) },
            placeholder: "Selecciona",
            width: 250
        )
        
        ESSegmentedPicker(
            selection: .constant("Opción 2"),
            options: ["Opción 1", "Opción 2", "Opción 3"],
            label: { Text($0) },
            width: 250
        )
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.dark)
}
