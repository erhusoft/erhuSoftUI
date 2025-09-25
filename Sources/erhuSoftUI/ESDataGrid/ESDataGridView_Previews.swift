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
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero")
            ],
            rowHeight: 40,
            defaultItemsPerPage: 10,
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
                }
            },
            rowContent: { _, user in
                HStack {
                    Text(user.username).frame(maxWidth: .infinity)
                    Text(user.email).frame(maxWidth: .infinity)
                    Text(user.role).frame(maxWidth: .infinity)
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
        .background(ThemeManager.bg(for: .light)) // 👈 Fondo Light
                .preferredColorScheme(.light)
    }
}

#Preview("DataGrid Dark") {
    StatefulPreviewWrapper(nil) { selection in
        ESDataGridView(
            items: [
                MockUser(username: "Ana", email: "ana@mail.com", role: "Admin"),
                MockUser(username: "Luis", email: "luis@mail.com", role: "Mesero"),
                MockUser(username: "Marta", email: "marta@mail.com", role: "Cajero")
            ],
            rowHeight: 40,
            defaultItemsPerPage: 10,
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
                }
            },
            rowContent: { _, user in
                HStack {
                    Text(user.username).frame(maxWidth: .infinity)
                    Text(user.email).frame(maxWidth: .infinity)
                    Text(user.role).frame(maxWidth: .infinity)
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
        .background(ThemeManager.bg(for: .dark)) // 👈 Fondo Light
                .preferredColorScheme(.dark)
    }
}
