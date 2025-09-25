//
//  ESNavLink_Previews.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

// MARK: - Previews
#Preview("Light") {
    if #available(macOS 13.0, iOS 16, *) {
        NavigationStack {
            VStack(spacing: 12) {
                ESNavLink(title: "Reporte de Ventas", destination: Text("Ventas"))
                ESNavLink(title: "Configuración", destination: Text("Config"), icon: "gearshape")
            }
            .padding()
            .background(Color.bg)
        }
        .preferredColorScheme(.light)
    } else {
        NavigationView{
            VStack(spacing: 12) {
                ESNavLink(title: "Reporte de Ventas", destination: Text("Ventas"))
                ESNavLink(title: "Configuración", destination: Text("Config"), icon: "gearshape")
            }
            .padding()
            .background(Color.bg)
        }
    }
}

#Preview("Dark") {
    if #available(macOS 13.0, iOS 16, *) {
        NavigationStack {
            VStack(spacing: 12) {
                ESNavLink(title: "Reporte de Ventas", destination: Text("Ventas"))
                ESNavLink(title: "Configuración", destination: Text("Config"), icon: "gearshape")
            }
            .padding()
            .background(Color.bg)
        }
        .preferredColorScheme(.dark)
    } else {
        NavigationView{
            VStack(spacing: 12) {
                ESNavLink(title: "Reporte de Ventas", destination: Text("Ventas"))
                ESNavLink(title: "Configuración", destination: Text("Config"), icon: "gearshape")
            }
            .padding()
            .background(Color.bg)
        }

    }
}
