//
//  ThemeManager.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

public enum ThemeManager {

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
    static let rowHover  = Color("rowHover", bundle: .module)

    // Texto
    static let textPrimary   = Color("textPrimary", bundle: .module)
    static let textSecondary = Color("textSecondary", bundle: .module)

    // Estado
    static let warning = Color("warning", bundle: .module)
    static let danger  = Color("danger", bundle: .module)
    static let success = Color("success", bundle: .module)
    static let info    = Color("info", bundle: .module)
}


