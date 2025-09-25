//
//  ESPadding.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - Padding Enum
public enum ESPadding: CGFloat {
    case zero = 0
    case xs   = 4
    case s    = 8
    case m    = 12
    case l    = 16
    case xl   = 24
    case xxl  = 32
    case xxxl = 48
    
    public func value() -> CGFloat { self.rawValue }
}

// MARK: - ViewModifier
public struct ESPaddingModifier: ViewModifier {
    let edge: Edge.Set
    let padding: ESPadding
    
    public func body(content: Content) -> some View {
        content.padding(edge, padding.value())
    }
}

// MARK: - Extension View
public extension View {
    func esPadding(_ edge: Edge.Set = .all, _ padding: ESPadding = .m) -> some View {
        self.modifier(ESPaddingModifier(edge: edge, padding: padding))
    }
    
    func esPadding(_ padding: ESPadding = .m) -> some View {
        self.modifier(ESPaddingModifier(edge: .all, padding: padding))
    }
}

// MARK: - Preview
#Preview("ESPadding") {
    VStack(spacing: 12) {
        Text("Zero").background(Color.yellow).esPadding(.all, .zero).background(Color.red)
        Text("XS").background(Color.yellow).esPadding(.all, .xs).background(Color.red)
        Text("S").background(Color.yellow).esPadding(.all, .s).background(Color.red)
        Text("M").background(Color.yellow).esPadding(.all, .m).background(Color.red)
        Text("L").background(Color.yellow).esPadding(.all, .l).background(Color.red)
        Text("XL").background(Color.yellow).esPadding(.all, .xl).background(Color.red)
        Text("XXL").background(Color.yellow).esPadding(.all, .xxl).background(Color.red)
        Text("XXXL").background(Color.yellow).esPadding(.all, .xxxl).background(Color.red)
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}
