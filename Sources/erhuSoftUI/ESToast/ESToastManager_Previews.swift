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
<<<<<<< HEAD
    .background(Color.bg)
=======
    .background(ThemeManager.bg(for: .light))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
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
<<<<<<< HEAD
    .background(Color.bg)
=======
    .background(ThemeManager.bg(for: .dark))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    .preferredColorScheme(.dark)
}
