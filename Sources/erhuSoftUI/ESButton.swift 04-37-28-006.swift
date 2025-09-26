//
//  ESButton.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI


public struct ESButton: View {
    @Environment(\.colorScheme) private var scheme   // 👈 leer el tema actual
    
    public var title: String
    public var action: () -> Void
    public var customColor: Color?   // 👈 color opcional
    
    public init(title: String,
                color: Color? = nil,
                action: @escaping () -> Void) {
        self.title = title
        self.customColor = color
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(ThemeManager.buttonFont)
                .padding(ThemeManager.padding)
                .frame(maxWidth: .infinity)
                .background(
                    customColor ?? ThemeManager.btn(for: scheme) // 👈 fallback automático
                )
               
           
                .cornerRadius(ThemeManager.cornerRadius)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}
// 🔹 Preview solo para desarrollo (no se exporta al package final)
#Preview("Light") {
    VStack(spacing: 20) {
        ESButton(title: "Primario") { }
        ESButton(title: "Secundario", color: .green) { }
        ESButton(title: "Peligro", color: .red) { }
    }
    .preferredColorScheme(.light)
    .padding()
    .background(ThemeManager.bg(for: .light))
}
#Preview("Dark") {
    VStack(spacing: 20) {
        ESButton(title: "Primario") { }
        ESButton(title: "Secundario", color: .green) { }
        ESButton(title: "Peligro", color: .red) { }
    }
    .preferredColorScheme(.dark)
    .padding()
    .background(ThemeManager.bg(for: .dark))
}
