//
//  ESPickerStepper.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
//  Componente SwiftUI para crear un control stepper con campo de texto editable.
//  Permite incrementar, decrementar y editar valores numéricos con validación de rango.
//

import SwiftUI

/// Un control stepper con campo de texto editable para valores numéricos.
/// Permite incrementar, decrementar y editar el valor, con validación de rango y formato.
public struct ESPickerStepper: View {
    @Environment(\.colorScheme) private var scheme
    /// Valor numérico actual (enlazado).
    @Binding var value: Double
    /// Valor textual actual (enlazado).
    @Binding var textValue: String
    /// Paso de incremento/decremento.
    var step: Double
    /// Valor mínimo permitido.
    var min: Double?
    /// Valor máximo permitido.
    var max: Double?
   
    @FocusState private var isFocused: Bool
    /// Inicializa el control ESPickerStepper.
    /// - Parameters:
    ///   - value: Binding al valor numérico.
    ///   - textValue: Binding al valor textual.
    ///   - step: Paso de incremento/decremento (por defecto 1).
    ///   - min: Valor mínimo permitido (opcional).
    ///   - max: Valor máximo permitido (opcional).
    public init(
        value: Binding<Double>,
        textValue: Binding<String>,
        step: Double = 1,
        min: Double? = nil,
        max: Double? = nil
    ) {
        self._value = value
        self._textValue = textValue
        self.step = step
        self.min = min
        self.max = max
    }
    
    /// Vista principal del control stepper con campo de texto.
    public var body: some View {
        HStack(spacing: 16) {
            ESStepperButton(action: decrement, icon: "minus.circle", color: .red)
            
            TextField("", text: $textValue)
                .textFieldStyle(.plain) // 👈 aplicar primero para limpiar estilo nativo
                .frame(width: 70)
                .multilineTextAlignment(.center)
                .focused($isFocused)
                .submitLabel(.done)
               .padding(.vertical, 6)
                .padding(.horizontal, 6)
               .background(Color.bg) // ✅ fondo consistente
               .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.border, lineWidth: 0.6) // ✅ borde consistente
                )
                .font(.system(size: 14, weight: .light))
                .onAppear { updateText() }
                .onChange(of: value) { _ in
                    if !isFocused { updateText() }
                }
                .onChange(of: textValue) { newText in
                    syncFromText(newText)
                }
                .onSubmit { syncFromText(textValue) }
                .onChange(of: isFocused) { newValue in
                    if !newValue { syncFromText(textValue) }
                }
            
            ESStepperButton(action: increment, icon: "plus.circle", color: .green)
        }
    }
    
    /// Actualiza el valor textual según el valor numérico.
    private func updateText() {
        textValue = String(format: "%.3f", value)
    }
    
    /// Sincroniza el valor numérico desde el texto ingresado, validando rango y formato.
    /// - Parameter newText: Texto ingresado por el usuario.
    private func syncFromText(_ newText: String) {
        let filtered = newText.replacingOccurrences(of: ",", with: ".")
        if let doubleValue = Double(filtered) {
            let rounded = round(doubleValue * 1000) / 1000
            if let min, rounded < min {
                value = min
            } else if let max, rounded > max {
                value = max
            } else {
                value = rounded
            }
        }
    }
    
    /// Incrementa el valor numérico respetando el máximo permitido.
    private func increment() {
        let newValue = value + step
        if max == nil || newValue <= max! {
            value = round(newValue * 1000) / 1000
            updateText()
        }
    }
    
    /// Decrementa el valor numérico respetando el mínimo permitido.
    private func decrement() {
        let newValue = value - step
        if min == nil || newValue >= min! {
            value = round(newValue * 1000) / 1000
            updateText()
        }
    }
}

#Preview("ESPickerStepper Light") {
    StatefulPreviewWrapper((1.0, "1.000")) { binding in
        let (value, textValue) = binding.wrappedValue
        ESPickerStepper(
            value: Binding(get: { value }, set: { binding.wrappedValue.0 = $0 }),
            textValue: Binding(get: { textValue }, set: { binding.wrappedValue.1 = $0 }),
            step: 0.5,
            min: 0,
            max: 10
        )
        .padding()
        .background(Color.bg)
        .preferredColorScheme(.light)
    }
}

#Preview("ESPickerStepper Dark") {
    StatefulPreviewWrapper((1.0, "1.000")) { binding in
        let (value, textValue) = binding.wrappedValue
        ESPickerStepper(
            value: Binding(get: { value }, set: { binding.wrappedValue.0 = $0 }),
            textValue: Binding(get: { textValue }, set: { binding.wrappedValue.1 = $0 }),
            step: 0.5,
            min: 0,
            max: 10
        )
        .padding()
        .background(Color.bg)
        .preferredColorScheme(.dark)
    }
}
