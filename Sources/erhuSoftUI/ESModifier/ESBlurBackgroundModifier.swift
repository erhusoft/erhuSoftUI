//
//  ESBlurBackgroundModifier.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

// MARK: - Cross-Platform Blur View
#if os(iOS)
import UIKit

public struct ESBlurredBackgroundView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#elseif os(macOS)
import AppKit

public struct ESBlurredBackgroundView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    
    public func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
#endif

// MARK: - Modifier
public struct ESBlurBackgroundModifier: ViewModifier {
    #if os(iOS)
    let style: UIBlurEffect.Style
    public func body(content: Content) -> some View {
        content.background(
            ESBlurredBackgroundView(style: style)
                .ignoresSafeArea()
        )
    }
    #elseif os(macOS)
    let material: NSVisualEffectView.Material
    public func body(content: Content) -> some View {
        content.background(
            ESBlurredBackgroundView(material: material)
                .ignoresSafeArea()
        )
    }
    #endif
}

// MARK: - Extension
public extension View {
    #if os(iOS)
    func esBlurBackground(style: UIBlurEffect.Style = .systemThinMaterial) -> some View {
        self.modifier(ESBlurBackgroundModifier(style: style))
    }
    #elseif os(macOS)
    /// Usa materiales modernos, por ejemplo `.contentBackground` o `.hudWindow`
    func esBlurBackground(material: NSVisualEffectView.Material = .contentBackground) -> some View {
        self.modifier(ESBlurBackgroundModifier(material: material))
    }
    #endif
    
    /// Atajo para blur claro
    func esBlurLight() -> some View {
        #if os(iOS)
        self.esBlurBackground(style: .systemThinMaterialLight)
        #else
        self.esBlurBackground(material: .contentBackground) // ✅ moderno
        #endif
    }
    
    /// Atajo para blur oscuro
    func esBlurDark() -> some View {
        #if os(iOS)
        self.esBlurBackground(style: .systemThinMaterialDark)
        #else
        self.esBlurBackground(material: .hudWindow) // ✅ moderno
        #endif
    }
}

// MARK: - Preview
#Preview("ESBlurBackground Dark") {
    VStack(spacing: 16) {
        Text("Dark Blur")
            .padding()
            .foregroundStyle(.red)
            .background(.red.opacity(0.1))
            .cornerRadius(8)
            .esBlurDark()
        
        ESTag(text: "Demo", tint: .red, color: .red)
            .esBlurDark()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
    .preferredColorScheme(.dark)
}

#Preview("ESBlurBackground Light") {
    VStack(spacing: 16) {
        Text("Light Blur")
            .padding()
            .cornerRadius(8)
            .esBlurLight()
        
        ESTag(text: "Demo")
            .esBlurLight()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
    .preferredColorScheme(.light)
}
