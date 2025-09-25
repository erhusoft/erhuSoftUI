//
//  ESButton.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
import SwiftUI

public enum ESButtonStyleType {
    case horizontal
    case vertical
    case fixedGrid(width: CGFloat = 90, height: CGFloat = 70)
    case fullWidth
    case tag
    case custom(width: CGFloat?, height: CGFloat?)
}

public struct ESButton: View {
    @Environment(\.colorScheme) private var scheme
    
    public var title: String
    public var icon: String?
    public var color: Color
    public var style: ESButtonStyleType
    public var action: (() -> Void)?
    
    public init(
        title: String,
        icon: String? = nil,
        color: Color = .blue,
        style: ESButtonStyleType = .horizontal,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.color = color
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            content
                .padding(8)
                .frame(maxWidth: {
                    switch style {
                    case .fullWidth:
                        return .infinity
                    default:
                        return nil
                    }
                }())
                .frame(width: frameWidth, height: frameHeight)
                .background(backgroundView)
                .cornerRadius(6)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        switch style {
        case .horizontal:
            HStack(spacing: 6) { iconView(fontSize: 16); textView }
        case .vertical:
            VStack(spacing: 6) { iconView(fontSize: 16); textView }
        case .fullWidth:
            textView.frame(maxWidth: .infinity)
        case .fixedGrid:
            VStack { iconView(fontSize: 22); textView }
        case .tag:
            HStack { iconView(fontSize: 10); textView }
        case .custom:
            HStack { iconView(fontSize: 14); textView }
        }
    }
    
    // MARK: - Icon
    @ViewBuilder
    private func iconView(fontSize: CGFloat) -> some View {
        if let icon {
            #if os(macOS)
            if let image = NSImage(named: icon) {
                Image(nsImage: image).resizable().scaledToFit()
                    .frame(width: fontSize, height: fontSize)
            } else {
                Image(systemName: icon).font(.system(size: fontSize))
            }
            #else
            if UIImage(named: icon) != nil {
                Image(icon).resizable().scaledToFit()
                    .frame(width: fontSize, height: fontSize)
            } else {
                Image(systemName: icon).font(.system(size: fontSize))
            }
            #endif
        }
    }
    
    // MARK: - Text
    private var textView: some View {
        Text(title)
            .font(.system(size: 14, weight: .light))
            .foregroundColor(color)
            .multilineTextAlignment(.center)
    }
    
    // MARK: - Frame
    private var frameWidth: CGFloat? {
        switch style {
        case .fixedGrid(let width, _): return width
        case .custom(let width, _): return width
        default: return nil
        }
    }
    
    private var frameHeight: CGFloat? {
        switch style {
        case .fixedGrid(_, let height): return height
        case .tag: return 20
        case .custom(_, let height): return height
        default: return nil
        }
    }
    
    // MARK: - Background
    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .fixedGrid:
            ThemeManager.grid(for: scheme)
        case .horizontal, .vertical, .tag, .custom:
            color.opacity(0.2)
        case .fullWidth:
            ThemeManager.bar(for: scheme)
        }
    }
}

#Preview("Light Mode") {
    VStack(spacing: 12) {
        ESButton(title: "Horizontal", icon: "pencil", color: .blue, style: .horizontal)
        ESButton(title: "Vertical", icon: "trash", color: .red, style: .vertical)
        ESButton(title: "Grid", icon: "person", style: .fixedGrid(width: 100, height: 80))
        ESButton(title: "Full Width", icon: "checkmark", color: .green, style: .fullWidth)
        ESButton(title: "Tag", icon: "star", color: .orange, style: .tag)
        ESButton(title: "Custom 140x50", icon: "bolt", color: .purple, style: .custom(width: 140, height: 50))
    }
    .padding()
    .background(ThemeManager.bg(for: .light))
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
    }
    .padding()
    .background(ThemeManager.bg(for: .dark))
    .preferredColorScheme(.dark)
}
