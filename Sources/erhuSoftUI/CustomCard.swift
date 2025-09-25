//
//  CustomCard.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

public struct CustomCard: View {
    @Environment(\.colorScheme) private var scheme
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mesa 1")
                .font(ThemeManager.xxl)
                //.foregroundColor(ThemeManager.textPrimary(for: scheme))
            
            Text("Cliente: Juan Pérez")
                .font(ThemeManager.m)
              //  .foregroundColor(ThemeManager.textSecondary(for: scheme))
        }
        .padding()
        .background(Color.card)
        .cornerRadius(ThemeManager.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                .stroke(Color.border, lineWidth: 0.5)
        )
    }
}

#Preview("Light") {
    CustomCard()
        .preferredColorScheme(.light)
        .padding()
        .background(Color.bg)
        .frame(width: 500, height: 500)
}

#Preview("Dark") {
    CustomCard()
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.bg)
        .frame(width: 500, height: 500)
}
