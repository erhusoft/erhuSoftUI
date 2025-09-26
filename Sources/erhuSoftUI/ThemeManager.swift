//
//  ThemeManager.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

public enum ThemeManager {
<<<<<<< HEAD
    // 🖋️ Tipografías xs,s,m,l,xl,xxl
    public static let xs: Font = .system(size: 12, weight: .light, design: .default)
    public static let s:  Font = .system(size: 14, weight: .light, design: .default)
    public static let m:  Font = .system(size: 16, weight: .light, design: .default)
    public static let l:  Font = .system(size: 20, weight: .light, design: .default)
    public static let xl: Font = .system(size: 24, weight: .light, design: .default)
    public static let xxl: Font = .system(size: 32, weight: .light, design: .default)

    // 📏 Layout
    public static let cornerRadius: CGFloat = 8
}

// MARK: - 🎨 Colores de Assets
public extension Color {
    static let bg         = Color("bg", bundle: .module)
    static let bar        = Color("bar", bundle: .module)
    static let border     = Color("border", bundle: .module)
    static let grid       = Color("grid", bundle: .module)
    static let row        = Color("row", bundle: .module)
    static let card       = Color("card", bundle: .module)
    static let selection  = Color("selection", bundle: .module)
    static let btn        = Color("btn", bundle: .module)
    static let btnText    = Color("btnText", bundle: .module)

    // Texto
    static let textPrimary   = Color("textPrimary", bundle: .module)
    static let textSecondary = Color("textSecondary", bundle: .module)

    // Estado
    static let warning = Color("warning", bundle: .module)
    static let danger  = Color("danger", bundle: .module)
    static let success = Color("success", bundle: .module)
    static let info    = Color("info", bundle: .module)
=======
    // MARK: - 🎨 Paleta completa con Light/Dark
    
    // color bg fondo
    public static func bg(for scheme: ColorScheme) -> Color {
        return scheme == .dark ? Color(hex: "#171717") : Color(hex: "#F6F6F6")
    }
    // color bar para barras
    public static func bar(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#1A1A1A") : Color(hex: "#E6E6E6")
    }
    // color border se puede utilizar para los borders de textbox, button etc.
    public static func border(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#2F2F2F") : Color(hex: "#868686")
    }
    // color grid, para los datagrid para alternar
    public static func grid(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#141414") : Color(hex: "#F2F2F2")
    }
    // color row, para los datagrid para alternar
    public static func row(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#131313") : Color(hex: "#EEEEEE")
    }
    // color card, para  las tarjetas
    public static func card(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#111111") : Color(hex: "#E6E6E6")
    }
    // color selection, para la seleccion de datagrid
    public static func selection(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#007ACC") : Color(hex: "#3399FF")
    }
    // color btn, fondo del boton
    public static func btn(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#333333") : Color(hex: "#b3b3b3")
    }
    // color btnText, para el color del text dentro del boton
    public static func btnText(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: "#FEFEFE") : Color(hex: "#1C1B1D")
    }
    // MARK: - 📝 Texto
    
    public static func textPrimary(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white : Color.black
    }
    
    public static func textSecondary(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.gray : Color(hex: "#444444")
    }
    
    // MARK: - 🚨 Estado
    
    public static func danger(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .orange : .red
    }
    
    public static func success(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .mint : .green
    }
    
    // MARK: - 🖋️ Tipografías
    
    public static var bodyFont: Font {
        .system(size: 16, weight: .light, design: .default)
    }
    
    public static var titleFont: Font {
        .system(size: 20, weight: .light, design: .rounded)
    }
    
    public static var buttonFont: Font {
        .system(size: 14, weight: .light, design: .rounded)
    }
    
    // MARK: - 📏 Layout
    public static let padding: CGFloat = 12
    public static let cornerRadius: CGFloat = 8
}

// MARK: - 🔧 Extensión para hex
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12 bits)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24 bits)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32 bits)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
}
