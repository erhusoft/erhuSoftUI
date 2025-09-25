//
//  ESSizeModifier.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

import SwiftUI

// MARK: - Dimension genérica
public enum ESDimension: Equatable {
    case none
    case fill      // ocupa todo el espacio disponible
    case fixed(CGFloat)
    
    func value() -> CGFloat? {
        switch self {
        case .none: return nil
        case .fill: return nil // se resuelve con GeometryReader
        case .fixed(let v): return v
        }
    }
}

// MARK: - Tamaño compuesto
public struct ESSize: Equatable {
    public var width: ESDimension
    public var height: ESDimension
    
    public init(width: ESDimension = .none, height: ESDimension = .none) {
        self.width = width
        self.height = height
    }
    
    // Atajos
    public static func square(_ value: CGFloat) -> ESSize {
        ESSize(width: .fixed(value), height: .fixed(value))
    }
    
    public static func fixed(width: CGFloat, height: CGFloat) -> ESSize {
        ESSize(width: .fixed(width), height: .fixed(height))
    }
    
    public static var fill: ESSize {
        ESSize(width: .fill, height: .fill)
    }
}

// MARK: - Modifier
public struct ESSizeModifier: ViewModifier {
    let size: ESSize
    
    public func body(content: Content) -> some View {
        Group {
            if size.width == .fill || size.height == .fill {
                GeometryReader { geo in
                    content.frame(
                        width: calculate(size.width, total: geo.size.width),
                        height: calculate(size.height, total: geo.size.height)
                    )
                }
            } else {
                content.frame(
                    width: size.width.value(),
                    height: size.height.value()
                )
            }
        }
    }
    
    private func calculate(_ dimension: ESDimension, total: CGFloat) -> CGFloat? {
        switch dimension {
        case .fill: return total
        default: return dimension.value()
        }
    }
}

// MARK: - Extension View
public extension View {
    func esSize(_ size: ESSize) -> some View {
        self.modifier(ESSizeModifier(size: size))
    }
    
    func esSize(_ value: CGFloat) -> some View {
        self.modifier(ESSizeModifier(size: .square(value)))
    }
    
    func esSize(width: CGFloat, height: CGFloat) -> some View {
        self.modifier(ESSizeModifier(size: .fixed(width: width, height: height)))
    }
}

// MARK: - Preview
#Preview("ESSizeModifier") {
    VStack(spacing: 16) {
        Color.red.esSize(40)                          // cuadrado 40x40
        Color.blue.esSize(width: 100, height: 40)     // 100x40
        Color.green.esSize(.fill)                     // ocupa todo
        Color.orange.esSize(.fixed(width: 60, height: 120)) // 60x120
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}
