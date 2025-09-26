//
//  ESButton.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

public struct ESButton: View {
    @Environment(\.colorScheme) private var scheme   // 👈 tema actual
    
    public var title: String
    public var action: () -> Void
    public var customColor: Color?   // 👈 color opcional
    public var buttonWidth: CGFloat? // 👈 ancho opcional
    
    public init(
        title: String,
        color: Color? = nil,
        width: CGFloat? = .infinity,   // 👈 default: full width
        action: @escaping () -> Void
    ) {
        self.title = title
        self.customColor = color
        self.buttonWidth = width
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(ThemeManager.buttonFont)
                .padding(ThemeManager.padding)
                .frame(
                    maxWidth: buttonWidth ?? .infinity // 👈 configurable
                )
                .background(customColor ?? ThemeManager.btn(for: scheme))
                .foregroundColor(ThemeManager.textPrimary(for: scheme))
                .cornerRadius(ThemeManager.cornerRadius)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

// MARK: - Previews
#Preview("Light") {
    VStack(spacing: 20) {
        ESButton(title: "Full width") { }                  // default .infinity
        ESButton(title: "Fixed 200", width: 200) { }       // 👈 ancho fijo
        ESButton(title: "Compact", color: .red, width: 120) { }
    }
    .preferredColorScheme(.light)
    .padding()
    .background(Color.bg)
}

#Preview("Dark") {
    VStack(spacing: 20) {
        ESButton(title: "Full width") { }
        ESButton(title: "Fixed 200", color: .green, width: 200) { }
        ESButton(title: "Compact", color: .orange, width: 120) { }
    }
    .preferredColorScheme(.dark)
    .padding()
    .background(color.bg)
}
