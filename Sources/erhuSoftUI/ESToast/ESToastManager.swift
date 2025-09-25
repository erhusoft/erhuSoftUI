//
//  ESToastManager.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - Modelo
public struct ESToast: Identifiable, Equatable {
    public let id = UUID()
    public let type: ESToastType
    public let title: String
    public let message: String?
    public let duration: TimeInterval
    
    public init(
        type: ESToastType,
        title: String,
        message: String? = nil,
        duration: TimeInterval = 3.0
    ) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
    }
}

// MARK: - Enum ToastType
public enum ESToastType {
    case success, error, info, warning, loading
    
    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .loading: return "arrow.clockwise.circle.fill"
        }
    }
    
    func primaryColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .success: return Color.success
        case .error:   return Color.danger
        case .info:    return Color.info
        case .warning: return Color.warning
        case .loading: return .gray
        }
    }
    
    func backgroundColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .success: return Color.success.opacity(0.15)
        case .error:   return Color.danger.opacity(0.15)
        case .info:    return Color.info.opacity(0.15)
        case .warning: return Color.warning.opacity(0.15)
        case .loading: return .gray.opacity(0.15)
        }
    }
}

// MARK: - ToastView
public struct ESToastView: View {
    @Environment(\.colorScheme) private var scheme
    let toast: ESToast
    
    @State private var isVisible: Bool = false
    @State private var rotationAngle: Double = 0
    
    public var body: some View {
        HStack(spacing: 12) {
            Group {
                if toast.type == .loading {
                    Image(systemName: toast.type.iconName)
                        .foregroundColor(toast.type.primaryColor(for: scheme))
                        .rotationEffect(Angle(degrees: rotationAngle))
                        .onAppear {
                            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                                rotationAngle += 360
                            }
                        }
                } else {
                    Image(systemName: toast.type.iconName)
                        .foregroundColor(toast.type.primaryColor(for: scheme))
                }
            }
            .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(toast.title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(toast.type.primaryColor(for: scheme))
                
                if let message = toast.message {
                    Text(message)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color.textSecondary)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 5)
        .frame(maxWidth: 400)
        .background(
            RoundedRectangle(cornerRadius: ThemeManager.cornerRadius, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                        .fill(Color.grid.opacity(0.35))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: ThemeManager.cornerRadius)
                        .stroke(Color.border, lineWidth: 0.5)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .scaleEffect(isVisible ? 1 : 0.8)
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isVisible = true
            }
        }
    }
}

// MARK: - ToastManager
public class ESToastManager: ObservableObject {
    public static let shared = ESToastManager()
    @Published public var toasts: [ESToast] = []
    
    private init() {}
    
    public func show(_ toast: ESToast) {
        toasts.append(toast)
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
            self.dismiss(toast)
        }
    }
    
    public func dismiss(_ toast: ESToast) {
        withAnimation(.easeInOut(duration: 0.3)) {
            toasts.removeAll { $0.id == toast.id }
        }
    }
    
    public func dismissAll() {
        withAnimation(.easeInOut(duration: 0.3)) {
            toasts.removeAll()
        }
    }
}

// MARK: - Container
public struct ESToastContainer: View {
    @EnvironmentObject var toastManager: ESToastManager
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    ForEach(toastManager.toasts) { toast in
                        ESToastView(toast: toast)
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                            .onTapGesture {
                                toastManager.dismiss(toast)
                            }
                    }
                }
                .padding(.top, 20)
                .padding(.trailing, 16)
            }
            Spacer()
        }
        .allowsHitTesting(false)
    }
}

// MARK: - View Extension
public extension View {
    func toast() -> some View {
        ZStack {
            self
            ESToastContainer().environmentObject(ESToastManager.shared)
        }
    }
}


// uso de ESToastManager
/*
struct ContentView: View {
    @EnvironmentObject var toastManager: ESToastManager
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Éxito") {
                toastManager.show(Toast(type: .success, title: "Guardado", message: "Operación exitosa"))
            }
            Button("Error") {
                toastManager.show(Toast(type: .error, title: "Fallo", message: "No se pudo guardar"))
            }
            Button("Cargando") {
                toastManager.show(Toast(type: .loading, title: "Cargando..."))
            }
        }
        .toast()
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ESToastManager.shared)
        }
    }
}*/
