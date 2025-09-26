//
//  ESTextField.swift
//  erhuSoftUI
//
<<<<<<< HEAD
//  Created by erhusoft on 26/09/25.
//

import SwiftUI

#if os(iOS)
import UIKit
public typealias ESKeyboardType = UIKeyboardType
#else
import AppKit
public enum ESKeyboardType {
    case `default`
    case emailAddress
    case decimalPad
}
#endif

// MARK: - Tipo de campo
/// Tipos de campo disponibles para ESTextField.
///
/// - normal: Campo de texto estándar.
/// - email: Campo para correos electrónicos.
/// - decimal: Campo para números decimales.
/// - currency: Campo para valores monetarios.
/// - secure: Campo seguro para contraseñas.
public enum ESTextFieldType {
    case normal
    case email
    case decimal
    case currency
    case secure
}

// MARK: - TextField Genérico
/// Campo de texto personalizable para SwiftUI.
///
/// Permite mostrar un campo de texto con diferentes tipos, ícono opcional y estilos adaptativos.
///
/// Ejemplo de uso:
/// ```swift
/// ESTextField(placeholder: "Correo", text: $email, type: .email, icon: "envelope")
/// ```
public struct ESTextField: View {
    @Environment(\.colorScheme) private var scheme
    
    public var placeholder: String
    @Binding public var text: String
    public var type: ESTextFieldType = .normal
    public var icon: String? = nil  // opcional (SF Symbol o asset)
    
    @State private var isSecure: Bool = true
    @FocusState private var isFocused: Bool
    
    /// Inicializa un campo de texto personalizado.
    /// - Parameters:
    ///   - placeholder: Texto de ayuda.
    ///   - text: Binding al valor del campo.
    ///   - type: Tipo de campo (ver ESTextFieldType).
    ///   - icon: Ícono SF Symbol o asset (opcional).
    public init(
        placeholder: String,
        text: Binding<String>,
        type: ESTextFieldType = .normal,
        icon: String? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.type = type
        self.icon = icon
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            // MARK: - Icono Izquierdo
            if let icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .frame(width: 16, height: 16)
            }
            
            // MARK: - Campo
            if type == .secure {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .focused($isFocused)
                
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye" : "eye.slash")
                        .foregroundColor(.gray.opacity(0.7))
                }
                .buttonStyle(.plain)
            } else {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
            }
        }
#if os(iOS)
        .keyboardType(keyboardType)
#endif
        .autocorrectionDisabled()
        .textFieldStyle(.plain)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.bar)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.border, lineWidth: 0.6)
        )
        .font(.system(size: 14, weight: .light))
        
        .onChange(of: text) { newValue in
            handleInput(newValue)
        }
    }
    
    // MARK: - Helpers
    private var keyboardType: ESKeyboardType {
        switch type {
        case .email: return .emailAddress
        case .decimal, .currency: return .decimalPad
        default: return .default
        }
    }
    
    private func handleInput(_ newValue: String) {
        switch type {
        case .decimal:
            let clean = newValue.replacingOccurrences(of: ",", with: ".")
            if Double(clean) == nil, !clean.isEmpty {
                text = String(clean.dropLast())
            }
        case .currency:
            let clean = newValue.replacingOccurrences(
                of: "[^0-9.]", with: "",
                options: .regularExpression
            )
            if let number = Double(clean) {
                text = ESFormatUtils.formatCurrency(number)
            }
        case .normal:
            text = newValue.capitalizedWords()
        default:
            break
        }
    }
}

// MARK: - Preview
#Preview("Light") {
    VStack(spacing: 12) {
        ESTextField(placeholder: "Nombre", text: .constant("juan"), type: .normal, icon: "person")
        ESTextField(placeholder: "Correo", text: .constant("correo@ejemplo.com"), type: .email, icon: "envelope")
        ESTextField(placeholder: "Precio", text: .constant("123.45"), type: .decimal, icon: "number")
        ESTextField(placeholder: "Monto", text: .constant("$5,000.00"), type: .currency, icon: "dollarsign.circle")
        ESTextField(placeholder: "Contraseña", text: .constant("123456"), type: .secure, icon: "lock")
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 12) {
        ESTextField(placeholder: "Nombre", text: .constant("juan"), type: .normal, icon: "person")
        ESTextField(placeholder: "Buscar", text: .constant(""), type: .normal, icon: "magnifyingglass")
        ESTextField(placeholder: "Correo", text: .constant("correo@ejemplo.com"), type: .email, icon: "envelope")
        ESTextField(placeholder: "Precio", text: .constant("123.45"), type: .decimal, icon: "number")
        ESTextField(placeholder: "Monto", text: .constant("$5,000.00"), type: .currency, icon: "dollarsign.circle")
        ESTextField(placeholder: "Contraseña", text: .constant("123456"), type: .secure, icon: "lock")
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
    .preferredColorScheme(.dark)
}
extension String {
    func chunked(by pattern: [Int]) -> [String] {
        var result: [String] = []
        var current = self
        for length in pattern {
            guard !current.isEmpty else { break }
            let chunk = String(current.prefix(length))
            result.append(chunk)
            current = String(current.dropFirst(length))
        }
        return result
    }
}
extension String {
    func capitalizedWords() -> String {
        self.split(separator: " ").map {
            guard let first = $0.first else { return "" }
            return first.uppercased() + $0.dropFirst()
        }.joined(separator: " ")
=======
//  Created by erhusoft on 25/09/25.
//



import SwiftUI

public struct ESTextField: View {
    @Environment(\.colorScheme) private var scheme   // 👈 Detecta Light/Dark
    @Binding var text: String
    var placeholder: String
    var icon: String?

    public init(text: Binding<String>, placeholder: String, icon: String? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
    }

    public var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(ThemeManager.textSecondary(for: scheme))
            }
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .foregroundColor(ThemeManager.textPrimary(for: scheme))
                .font(ThemeManager.bodyFont)
        }
        .padding(ThemeManager.padding)
        .background(ThemeManager.grid(for: scheme)) // 👈 fondo adaptado
        .cornerRadius(ThemeManager.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                .stroke(ThemeManager.border(for: scheme), lineWidth: 0.5)
        )
        .padding(.horizontal)
    }
}

// 🔹 Preview
#Preview("Light") {
    PreviewWrapper()
        .preferredColorScheme(.light)
        .background(ThemeManager.bg(for: .light))
}

#Preview("Dark") {
    PreviewWrapper()
        .preferredColorScheme(.dark)
        .background(ThemeManager.bg(for: .dark))
}

private struct PreviewWrapper: View {
    @State private var input = ""

    var body: some View {
        VStack(spacing: 20) {
            ESTextField(text: $input, placeholder: "Nombre", icon: "person.fill")
            ESTextField(text: $input, placeholder: "Correo electrónico")
        }
        .padding()
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    }
}
