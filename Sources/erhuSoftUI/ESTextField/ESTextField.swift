//
//  ESTextField.swift
//  erhuSoftUI
//
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
    }
}
