//
//  ESDataGridView.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - SortDirection
/**
 Enumeración para representar la dirección de ordenamiento en la grilla de datos.
 - ascending: Orden ascendente.
 - descending: Orden descendente.
 */
public enum SortDirection {
    case ascending
    case descending

    /// Invierte la dirección de ordenamiento.
    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}

// MARK: - Encabezado Ordenable Reutilizable
/**
 Vista que representa un encabezado de columna ordenable en la grilla.

 - Parameters:
    - title: Texto del encabezado.
    - isActive: Indica si el encabezado está activo para ordenamiento.
    - direction: Dirección actual de ordenamiento.
    - action: Acción al hacer clic en el encabezado.

 - Example:
    SortableHeader(title: "Nombre", isActive: true, direction: .ascending) { /* acción */ }
*/
struct SortableHeader: View {
    let title: String
    let isActive: Bool
    let direction: SortDirection?
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .bold))
            if isActive, let direction {
                Image(systemName: direction == .ascending ? "arrow.up" : "arrow.down")
                    .foregroundColor(direction == .ascending ? .blue : .red)
                    .font(.caption2)
            }
        }
        .onTapGesture {
            action()
        }
    }
}

// MARK: - ESDataGridView
/**
 Vista de grilla de datos con soporte para ordenamiento, paginación, búsqueda y selección.

 Permite mostrar una lista de elementos en formato tabla, con encabezados ordenables, paginación opcional y búsqueda personalizada.

 - Parameters:
    - items: Arreglo de elementos a mostrar en la grilla. Deben ser Identifiable y Equatable.
    - rowHeight: Altura de cada fila de la grilla. Por defecto 35.
    - defaultItemsPerPage: Cantidad de elementos por página (paginación). Si es nil, muestra todos los elementos.
    - enableSearch: Activa la barra de búsqueda para filtrar los elementos.
    - filter: Función personalizada para filtrar los elementos según el texto de búsqueda.
    - header: Vista del encabezado, permite definir columnas y ordenamiento.
    - rowContent: Vista de cada fila, recibe el índice y el elemento.
    - sort: Función personalizada para ordenar los elementos.
    - selection: Binding para la selección de la fila actual.

 - Example:
 ```swift
 ESDataGridView(
   items: datos,
   rowHeight: 40,
   defaultItemsPerPage: 10,
   enableSearch: true,
   filter: { item, text in item.nombre.contains(text) },
   header: { sort, activeKey, direction in
     HStack {
       SortableHeader(title: "Nombre", isActive: activeKey == "nombre", direction: direction) {
         sort("nombre", direction ?? .ascending)
       }
       // ... otras columnas ...
     }
   },
   rowContent: { index, item in
     Text(item.nombre)
   },
   sort: { a, b, dir, key in /* lógica de ordenamiento */ },
   selection: $seleccion
 )
 ```
*/
public struct ESDataGridView<Header: View, Content: View, Item: Identifiable & Equatable>: View {
    @Environment(\.colorScheme) private var scheme
    /// Elementos a mostrar en la grilla
    var items: [Item]
    /// Altura de cada fila
    var rowHeight: CGFloat = 35
    /// Elementos por página (paginación)
    var defaultItemsPerPage: Int? = nil
    /// Título opcional para la grilla
    var title: String = ""
    /// Activa la barra de búsqueda
    var enableSearch: Bool = false
    /// Función personalizada para filtrar los elementos
    var filter: ((Item, String) -> Bool)?
    /// Vista del encabezado, permite definir columnas y ordenamiento
    var header: (
        _ sort: @escaping (String, SortDirection) -> Void,
        _ activeKey: String?,
        _ direction: SortDirection?
    ) -> Header
    /// Vista de cada fila, recibe el índice y el elemento
    var rowContent: (Int, Item) -> Content
    /// Función personalizada para ordenar los elementos
    var sort: ((Item, Item, SortDirection, String) -> Bool)?
    /// Binding para la selección de la fila actual
    @Binding var selection: Int?

    // MARK: - Estados internos
    @State private var sortDirection: SortDirection = .ascending
    @State private var activeSortKey: String? = nil
    @State private var isSorted: Bool = false
    @State private var currentPage: Int = 1
    @State private var itemsPerPage: Int? = nil
    @State private var searchText: String = ""

    /**
     Devuelve los elementos filtrados según el texto de búsqueda y la función de filtro.
    */
    private var filteredItems: [Item] {
        guard enableSearch, !searchText.isEmpty, let filter else { return items }
        return items.filter { filter($0, searchText) }
    }

    /**
     Devuelve los elementos ordenados según la función de ordenamiento y la clave activa.
    */
    private var sortedItems: [Item] {
        guard let sort, let key = activeSortKey, isSorted else { return filteredItems }
        return filteredItems.sorted { sort($0, $1, sortDirection, key) }
    }

    /**
     Devuelve los elementos paginados según la página actual y el número de elementos por página.
    */
    private var paginatedItems: [Item] {
        guard let itemsPerPage else { return sortedItems }
        let start = (currentPage - 1) * itemsPerPage
        let end = min(start + itemsPerPage, sortedItems.count)
        guard start < end else { return [] }
        return Array(sortedItems[start..<end])
    }

    /**
     Devuelve el número total de páginas según la cantidad de elementos y el número de elementos por página.
    */
    private var totalPages: Int {
        guard let itemsPerPage else { return 1 }
        return max(1, (sortedItems.count + itemsPerPage - 1) / itemsPerPage)
    }

    // MARK: - Init
    /**
     Inicializa la grilla de datos.
     - Parameters:
        - items: Elementos a mostrar.
        - rowHeight: Altura de cada fila.
        - title: Título opcional para la grilla.
        - defaultItemsPerPage: Elementos por página (paginación).
        - enableSearch: Activa búsqueda.
        - filter: Función de filtrado personalizada.
        - header: Vista del encabezado.
        - rowContent: Vista de cada fila.
        - sort: Función de ordenamiento personalizada.
        - selection: Binding para la selección.
    */
    public init(
        items: [Item],
        rowHeight: CGFloat = 35,
        defaultItemsPerPage: Int? = nil,
        title: String? = nil,
        enableSearch: Bool = false,
        filter: ((Item, String) -> Bool)? = nil,
        header: @escaping (
            _ sort: @escaping (String, SortDirection) -> Void,
            _ activeKey: String?,
            _ direction: SortDirection?
        ) -> Header,
        rowContent: @escaping (Int, Item) -> Content,
        sort: ((Item, Item, SortDirection, String) -> Bool)? = nil,
        selection: Binding<Int?>
    ) {
        self.items = items
        self.rowHeight = rowHeight
        self.defaultItemsPerPage = defaultItemsPerPage
        self.title = title ?? ""
        self.enableSearch = enableSearch
        self.filter = filter
        self.header = header
        self.rowContent = rowContent
        self.sort = sort
        self._selection = selection
    }

    // MARK: - Vista auxiliar para hover en filas
    private struct DataGridRow<Content: View>: View {
        let index: Int
        let isSelected: Bool
        let rowHeight: CGFloat
        let selectionAction: () -> Void
        let content: () -> Content
        @State private var isHovering = false

        var body: some View {
            content()
                .frame(height: rowHeight)
                .background(
                    isSelected ? Color.selection : (isHovering ? Color.rowHover : (index.isMultiple(of: 2) ? Color.row : Color.bg))
                )
                .contentShape(Rectangle())
                .onTapGesture { selectionAction() }
                .onHover { hovering in
                    isHovering = hovering
                }
        }
    }

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0) {
            
            // 🔍 Buscador arriba de la cabecera (si está habilitado)
            if enableSearch {
                HStack {
                    Text(title) // aqui quiero poner un título opcional
                        .font(.title2)
                        .padding(.horizontal)
                    Spacer()
                    ESTextField(placeholder: "Buscar", text: $searchText, type: .normal, icon: "magnifyingglass")
                        
                }
                .padding(.top, 5)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.bar)
            }
            
            // Encabezado ordenable
            header({ key, dir in
                sortDirection = dir
                activeSortKey = key
                isSorted = true
                currentPage = 1
            }, activeSortKey, isSorted ? sortDirection : nil)
                .frame(height: rowHeight)
                .background(Color.bar)
                .foregroundColor(Color.textPrimary)
            
            Divider()
            
            if items.isEmpty {
                VStack {
                    Image(systemName: "tray.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No hay datos para mostrar")
                        .font(.headline)
                        .foregroundColor(Color.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.bg)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(paginatedItems.enumerated()), id: \.offset) { index, item in
                            DataGridRow(
                                index: index,
                                isSelected: selection == index,
                                rowHeight: rowHeight,
                                selectionAction: { selection = index },
                                content: { rowContent(index, item) }
                            )
                        }
                    }
                }.animation(.easeInOut, value: paginatedItems)
                
            }
            
            // Paginación
            if defaultItemsPerPage != nil {
                HStack(spacing: 12) {
                    
                    
                    Spacer()
                    Picker("Filtrar", selection: Binding(get: {
                        itemsPerPage ?? defaultItemsPerPage ?? 20
                    }, set: { newValue in
                        itemsPerPage = newValue
                        currentPage = 1
                    })) {
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("15").tag(15)
                        Text("20").tag(20)
                        Text("25").tag(25)
                        Text("30").tag(30)
                        Text("35").tag(35)
                        Text("40").tag(40)
                        Text("45").tag(45)
                        Text("50").tag(50)
                    }
                    .pickerStyle(.menu)
                    .frame(width: 100)
                    .padding(.trailing, 20)
                    Button(action: {
                        if currentPage > 1 { currentPage -= 1 }
                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 20))
                    }
                    .buttonStyle(.plain)
                    .disabled(currentPage == 1)

                    Text("Página \(currentPage) de \(totalPages)")
                        .font(.footnote)
                        .foregroundColor(Color.textSecondary)

                    Button(action: {
                        if currentPage < totalPages { currentPage += 1 }
                    }) {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 20))
                    }.buttonStyle(.plain)
                    .disabled(currentPage == totalPages)
                }
                .padding(.top, 8)
            }
        }
        .onAppear { itemsPerPage = defaultItemsPerPage }
        .background(Color.bg)
    }
}
