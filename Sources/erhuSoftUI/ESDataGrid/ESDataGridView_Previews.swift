//
//  ESDataGridView_Previews.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//
import SwiftUI
// Modelo de prueba
struct MockUser: Identifiable, Equatable {
    let id = UUID()
    let username: String
    let email: String
    let role: String
}
/// Un wrapper para usar `@Binding` dentro de Previews
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
#Preview("DataGrid Light") {
    StatefulPreviewWrapper(nil) { selection in
        ESDataGridView(
            items: [
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero"),
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero"),
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero"),
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero")
            ],
            rowHeight: 40,
            defaultItemsPerPage: 10,
            title: "Usuarios",
            enableSearch: true, // Activar buscador
                filter: { user, text in
                    user.username.localizedCaseInsensitiveContains(text) ||
                    user.email.localizedCaseInsensitiveContains(text)
                },
            header: { sortAction, activeKey, direction in
                HStack {
                    SortableHeader(title: "Nombre", isActive: activeKey == "nombre", direction: direction) {
                        sortAction("nombre", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Correo", isActive: activeKey == "correo", direction: direction) {
                        sortAction("correo", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Rol", isActive: activeKey == "role", direction: direction) {
                        sortAction("role", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Actions", isActive: false, direction: nil) {
                        
                    }.frame(maxWidth: .infinity)
                }
            },
            rowContent: { _, user in
                HStack {
                    Text(user.username).frame(maxWidth: .infinity)
                    Text(user.email).frame(maxWidth: .infinity)
                    
                    ESTag(text: user.role, systemIcon: "person.fill", tint: .pink, color: .pink)
                        .frame(maxWidth: .infinity)
                    HStack{
                        ESButton(icon: "rectangle.portrait.badge.plus.fill", color: .blue, style: .icon(size: 12))
                        ESButton(icon: "clipboard.fill", color: .gray, style: .icon(size: 12))
                        ESButton(icon: "trash.fill", color: .red, style: .icon(size: 12))
                    }.frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 4)
            },
            sort: { a, b, dir, key in
                switch key {
                case "nombre": return dir == .ascending ? a.username < b.username : a.username > b.username
                case "correo": return dir == .ascending ? a.email < b.email : a.email > b.email
                case "role":   return dir == .ascending ? a.role < b.role : a.role > b.role
                default: return false
                }
            },
            selection: selection
        )
        .frame(height: 300)
        .padding()
        .background(Color.bg) // 👈 Fondo Light
                .preferredColorScheme(.light)
    }
}

#Preview("DataGrid Dark") {
    
    
    StatefulPreviewWrapper(nil) { selection in
        ESDataGridView(
            items: [
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero"),
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero"),
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero")
            ],
            rowHeight: 40,
            defaultItemsPerPage: 10,
            title: "Usuarios", // Sin título
            enableSearch: true, // Activar buscador
                filter: { user, text in
                    user.username.localizedCaseInsensitiveContains(text) ||
                    user.email.localizedCaseInsensitiveContains(text)
                },
            header: { sortAction, activeKey, direction in
                HStack {
                    SortableHeader(title: "Nombre", isActive: activeKey == "nombre", direction: direction) {
                        sortAction("nombre", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Correo", isActive: activeKey == "correo", direction: direction) {
                        sortAction("correo", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Rol", isActive: activeKey == "role", direction: direction) {
                        sortAction("role", direction == .ascending ? .descending : .ascending)
                    }.frame(maxWidth: .infinity)
                    SortableHeader(title: "Actions", isActive: false, direction: nil) {
                        
                    }.frame(maxWidth: .infinity)
                }
            },
            rowContent: { _, user in
                HStack {
                    Text(user.username).frame(maxWidth: .infinity)
                    Text(user.email).frame(maxWidth: .infinity)
                    ESTag(text: user.role, systemIcon: "person.fill", tint: .blue, color: .blue)
                        .frame(maxWidth: .infinity)
                    HStack{
                        ESButton(icon: "rectangle.portrait.badge.plus.fill", color: .blue, style: .icon(size: 12))
                        ESButton(icon: "clipboard.fill", color: .gray, style: .icon(size: 12))
                        ESButton(icon: "trash.fill", color: .red, style: .icon(size: 12))
                    }.frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 4)
            },
            sort: { a, b, dir, key in
                switch key {
                case "nombre": return dir == .ascending ? a.username < b.username : a.username > b.username
                case "correo": return dir == .ascending ? a.email < b.email : a.email > b.email
                case "role":   return dir == .ascending ? a.role < b.role : a.role > b.role
                default: return false
                }
            },
            selection: selection
        )
        .frame(height: 300)
        .padding()
        .background(Color.bg) // 👈 Fondo Light
                .preferredColorScheme(.dark)
    }
}
