//
//  ESButton_Previews.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

#Preview("Light Mode") {
    VStack(spacing: 12) {
        ESButton(title: "Horizontal", icon: "pencil", color: .blue, style: .horizontal)
        ESButton(title: "Vertical", icon: "trash", color: .red, style: .vertical)
        ESButton(title: "Grid", icon: "person", style: .fixedGrid(width: 100, height: 80))
        ESButton(title: "Full Width", icon: "checkmark", color: .green, style: .fullWidth)
        ESButton(title: "Tag", icon: "star", color: .orange, style: .tag)
        ESButton(title: "Custom 140x50", icon: "bolt", color: .purple, style: .custom(width: 140, height: 50))
        ESButton(icon: "heart.fill", color: .pink, style: .icon(size: 32)) // 👈 solo icono
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack(spacing: 12) {
        ESButton(title: "Horizontal", icon: "pencil", color: .blue, style: .horizontal)
        ESButton(title: "Vertical", icon: "trash", color: .red, style: .vertical)
        ESButton(title: "Grid", icon: "person", style: .fixedGrid(width: 100, height: 80))
        ESButton(title: "Full Width", icon: "checkmark", color: .green, style: .fullWidth)
        ESButton(title: "Tag", icon: "star", color: .orange, style: .tag)
        ESButton(title: "Custom 140x50", icon: "bolt", color: .purple, style: .custom(width: 140, height: 50))
        ESButton(icon: "heart.fill", color: .pink, style: .icon(size: 32)) // 👈 solo icono
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.dark)
}
