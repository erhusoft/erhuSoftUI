//
//  ESStepperButton.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
//  Componente SwiftUI para crear un botón de stepper con icono y color personalizables.
//  Permite incrementar o disminuir valores en controles tipo stepper.
//

import SwiftUI

/// Un botón personalizado para controles tipo stepper.
/// Permite definir el icono, color y tamaño, y ejecuta una acción al pulsarse.
public struct ESStepperButton: View {
    /// Acción que se ejecuta al pulsar el botón.
    let action: () -> Void
    /// Nombre del icono SF Symbol a mostrar.
    let icon: String
    /// Color del icono.
    let color: Color
    /// Tamaño del icono (por defecto 16).
    var size: CGFloat
    @Environment(\.colorScheme) private var scheme
    /// Inicializa un botón de stepper.
    /// - Parameters:
    ///   - action: Acción a ejecutar al pulsar el botón.
    ///   - icon: Nombre del SF Symbol a mostrar (ejemplo: "plus.circle").
    ///   - color: Color del icono.
    ///   - size: Tamaño del icono (por defecto 16).
    public init(
        action: @escaping () -> Void,
        icon: String,
        color: Color,
        size: CGFloat = 16
    ) {
        self.action = action
        self.icon = icon
        self.color = color
        self.size = size
    }
    
    /// Vista principal del botón stepper.
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size))
                .foregroundColor(color)
                .accessibilityLabel(
                    Text(icon == "plus.circle" ? "Incrementar" : "Disminuir")
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview("StepperButton Light") {
    VStack(spacing: 20) {
        ESStepperButton(action: {}, icon: "minus.circle", color: .red, size: 28)
        ESStepperButton(action: {}, icon: "plus.circle", color: .green, size: 28)
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}

#Preview("StepperButton Dark") {
    VStack(spacing: 20) {
        ESStepperButton(action: {}, icon: "minus.circle", color: .red, size: 28)
        ESStepperButton(action: {}, icon: "plus.circle", color: .green, size: 28)
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.dark)
}
