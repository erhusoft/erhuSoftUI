//
//  ESDataGridView.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - ESDataGridView
/// Vista de grilla de datos con soporte para ordenamiento, paginación, búsqueda y selección.
///
/// Permite mostrar una lista de elementos en formato tabla, con encabezados ordenables, paginación opcional y búsqueda personalizada.
///
/// - Parameters:
///   - items: Arreglo de elementos a mostrar en la grilla. Deben ser Identifiable y Equatable.
///   - rowHeight: Altura de cada fila de la grilla. Por defecto 35.
///   - defaultItemsPerPage: Cantidad de elementos por página (paginación). Si es nil, muestra todos los elementos.
///   - enableSearch: Activa la barra de búsqueda para filtrar los elementos.
///   - filter: Función personalizada para filtrar los elementos según el texto de búsqueda.
///   - header: Vista del encabezado, permite definir columnas y ordenamiento.
///   - rowContent: Vista de cada fila, recibe el índice y el elemento.
///   - sort: Función personalizada para ordenar los elementos.
///   - selection: Binding para la selección de la fila actual.
///
/// Ejemplo de uso:
/// ```swift
/// ESDataGridView(
///   items: datos,
///   header: { sort, activeKey, direction in ... },
///   rowContent: { index, item in ... },
///   selection: $seleccion
/// )
/// ```
public struct ESDataGridView<Header: View, Content: View, Item: Identifiable & Equatable>: View {
    @Environment(\.colorScheme) private var scheme
    
    var items: [Item]
    var rowHeight: CGFloat = 35
    var defaultItemsPerPage: Int? = nil
    
    // Nuevo: búsqueda y filtros
    var title: String = ""
    var enableSearch: Bool = false
    var filter: ((Item, String) -> Bool)?
    
    var header: (
        _ sort: @escaping (String, SortDirection) -> Void,
        _ activeKey: String?,
        _ direction: SortDirection?
    ) -> Header

    var rowContent: (Int, Item) -> Content
    var sort: ((Item, Item, SortDirection, String) -> Bool)?
    
    @Binding var selection: Int?
    
    @State private var sortDirection: SortDirection = .ascending
    @State private var activeSortKey: String? = nil
    @State private var isSorted: Bool = false
    @State private var currentPage: Int = 1
    @State private var itemsPerPage: Int? = nil
    
    // Nuevo: texto de búsqueda
    @State private var searchText: String = ""

    // MARK: - Procesamiento de items
    private var filteredItems: [Item] {
        guard enableSearch, !searchText.isEmpty, let filter else { return items }
        return items.filter { filter($0, searchText) }
    }

    private var sortedItems: [Item] {
        guard let sort, let key = activeSortKey, isSorted else { return filteredItems }
        return filteredItems.sorted { sort($0, $1, sortDirection, key) }
    }

    private var paginatedItems: [Item] {
        guard let itemsPerPage else { return sortedItems }
        let start = (currentPage - 1) * itemsPerPage
        let end = min(start + itemsPerPage, sortedItems.count)
        guard start < end else { return [] }
        return Array(sortedItems[start..<end])
    }

    private var totalPages: Int {
        guard let itemsPerPage else { return 1 }
        return max(1, (sortedItems.count + itemsPerPage - 1) / itemsPerPage)
    }

    // MARK: - Init
    /// Inicializa la grilla de datos.
    /// - Parameters:
    ///   - items: Elementos a mostrar.
    ///   - rowHeight: Altura de cada fila.
    ///   - title: Título opcional para la grilla.
    ///   - defaultItemsPerPage: Elementos por página (paginación).
    ///   - enableSearch: Activa búsqueda.
    ///   - filter: Función de filtrado personalizada.
    ///   - header: Vista del encabezado.
    ///   - rowContent: Vista de cada fila.
    ///   - sort: Función de ordenamiento personalizada.
    ///   - selection: Binding para la selección.
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
                            rowContent(index, item)
                                .frame(height: rowHeight)
                                .background(
                                    selection == index
                                    ? Color.selection
                                    : (index.isMultiple(of: 2)
                                        ? Color.row
                                        : Color.bg)
                                )
                                .contentShape(Rectangle())
                                .onTapGesture { selection = index }
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
