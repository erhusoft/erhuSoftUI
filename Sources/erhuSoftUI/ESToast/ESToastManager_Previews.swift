//
//  ESToastManager_Previews.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

#Preview("Toasts Light") {
    VStack(spacing: 12) {
        ESToastView(toast: ESToast(type: .success, title: "Éxito", message: "Guardado correctamente"))
        ESToastView(toast: ESToast(type: .error, title: "Error", message: "Ocurrió un problema"))
        ESToastView(toast: ESToast(type: .info, title: "Info", message: "Esto es un mensaje informativo"))
        ESToastView(toast: ESToast(type: .warning, title: "Advertencia", message: "Verifica los datos ingresados"))
        ESToastView(toast: ESToast(type: .loading, title: "Cargando...", message: "Espere un momento"))
    }
    .padding()
    .background(ThemeManager.bg(for: .light))
    .preferredColorScheme(.light)
}

#Preview("Toasts Dark") {
    VStack(spacing: 12) {
        ESToastView(toast: ESToast(type: .success, title: "Éxito", message: "Guardado correctamente"))
        ESToastView(toast: ESToast(type: .error, title: "Error", message: "Ocurrió un problema"))
        ESToastView(toast: ESToast(type: .info, title: "Info", message: "Esto es un mensaje informativo"))
        ESToastView(toast: ESToast(type: .warning, title: "Advertencia", message: "Verifica los datos ingresados"))
        ESToastView(toast: ESToast(type: .loading, title: "Cargando...", message: "Espere un momento"))
    }
    .padding()
    .background(ThemeManager.bg(for: .dark))
    .preferredColorScheme(.dark)
}
