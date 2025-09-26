//
//  ESDataGridView.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - SortDirection
<<<<<<< HEAD
/// Dirección de ordenamiento para columnas de la grilla de datos.
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
public enum SortDirection {
    case ascending
    case descending

    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}

// MARK: - SortableHeader
<<<<<<< HEAD
/// Encabezado de columna ordenable para la grilla de datos.
///
/// Permite mostrar el título, el estado de orden y ejecutar la acción de ordenamiento.
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
public struct SortableHeader: View {
    @Environment(\.colorScheme) private var scheme
    
    let title: String
    let isActive: Bool
    let direction: SortDirection?
    let action: () -> Void

<<<<<<< HEAD
    /// Inicializa un encabezado ordenable.
    /// - Parameters:
    ///   - title: Título de la columna.
    ///   - isActive: Indica si la columna está ordenada.
    ///   - direction: Dirección de ordenamiento.
    ///   - action: Acción al tocar el encabezado.
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    public init(title: String, isActive: Bool, direction: SortDirection?, action: @escaping () -> Void) {
        self.title = title
        self.isActive = isActive
        self.direction = direction
        self.action = action
    }

    public var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .bold))
<<<<<<< HEAD
                .foregroundColor(Color.textPrimary)
            if isActive, let direction {
                Image(systemName: direction == .ascending ? "arrow.up" : "arrow.down")
                    .foregroundColor(direction == .ascending ? Color.success : Color.danger)
=======
                .foregroundColor(ThemeManager.textPrimary(for: scheme))
            if isActive, let direction {
                Image(systemName: direction == .ascending ? "arrow.up" : "arrow.down")
                    .foregroundColor(direction == .ascending ? ThemeManager.success(for: scheme) : ThemeManager.danger(for: scheme))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
                    .font(.caption2)
            }
        }
        .onTapGesture { action() }
    }
}

// MARK: - ESDataGridView
<<<<<<< HEAD
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
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
public struct ESDataGridView<Header: View, Content: View, Item: Identifiable & Equatable>: View {
    @Environment(\.colorScheme) private var scheme
    
    var items: [Item]
    var rowHeight: CGFloat = 35
    var defaultItemsPerPage: Int? = nil
<<<<<<< HEAD
    
    // Nuevo: búsqueda y filtros
    var title: String = ""
    var enableSearch: Bool = false
    var filter: ((Item, String) -> Bool)?
    
=======

>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    var header: (
        _ sort: @escaping (String, SortDirection) -> Void,
        _ activeKey: String?,
        _ direction: SortDirection?
    ) -> Header

    var rowContent: (Int, Item) -> Content
    var sort: ((Item, Item, SortDirection, String) -> Bool)?
<<<<<<< HEAD
    
    @Binding var selection: Int?
    
=======

    @Binding var selection: Int?

>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    @State private var sortDirection: SortDirection = .ascending
    @State private var activeSortKey: String? = nil
    @State private var isSorted: Bool = false
    @State private var currentPage: Int = 1
    @State private var itemsPerPage: Int? = nil
<<<<<<< HEAD
    
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
=======
    @State private var lastItemCount: Int = 0

    private var sortedItems: [Item] {
        guard let sort, let key = activeSortKey, isSorted else { return items }
        return items.sorted { sort($0, $1, sortDirection, key) }
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
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

<<<<<<< HEAD
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
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
    public init(
        items: [Item],
        rowHeight: CGFloat = 35,
        defaultItemsPerPage: Int? = nil,
<<<<<<< HEAD
        title: String? = nil,
        enableSearch: Bool = false,
        filter: ((Item, String) -> Bool)? = nil,
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
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
<<<<<<< HEAD
        self.title = title ?? ""
        self.enableSearch = enableSearch
        self.filter = filter
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
        self.header = header
        self.rowContent = rowContent
        self.sort = sort
        self._selection = selection
    }

<<<<<<< HEAD
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
=======
    public var body: some View {
        VStack(spacing: 0) {
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
            header({ key, dir in
                sortDirection = dir
                activeSortKey = key
                isSorted = true
                currentPage = 1
            }, activeSortKey, isSorted ? sortDirection : nil)
                .frame(height: rowHeight)
<<<<<<< HEAD
                .background(Color.bar)
                .foregroundColor(Color.textPrimary)
            
            Divider()
            
=======
                .background(ThemeManager.bar(for: scheme))
                .foregroundColor(ThemeManager.textPrimary(for: scheme))

            Divider()

>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
            if items.isEmpty {
                VStack {
                    Image(systemName: "tray.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No hay datos para mostrar")
                        .font(.headline)
<<<<<<< HEAD
                        .foregroundColor(Color.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.bg)
=======
                        .foregroundColor(ThemeManager.textSecondary(for: scheme))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ThemeManager.bg(for: scheme))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(paginatedItems.enumerated()), id: \.offset) { index, item in
                            rowContent(index, item)
                                .frame(height: rowHeight)
<<<<<<< HEAD
                                .background(
                                    selection == index
                                    ? Color.selection
                                    : (index.isMultiple(of: 2)
                                        ? Color.row
                                        : Color.bg)
                                )
=======
                                .background(index.isMultiple(of: 2)
                                            ? ThemeManager.row(for: scheme)
                                            : ThemeManager.bg(for: scheme))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
                                .contentShape(Rectangle())
                                .onTapGesture { selection = index }
                        }
                    }
<<<<<<< HEAD
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
=======
                }
            }

            if defaultItemsPerPage != nil {
                HStack(spacing: 12) {
                    Spacer()
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
                    Button(action: {
                        if currentPage > 1 { currentPage -= 1 }
                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundColor(Color.gray)
<<<<<<< HEAD
                            .font(.system(size: 20))
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
                    }
                    .buttonStyle(.plain)
                    .disabled(currentPage == 1)

                    Text("Página \(currentPage) de \(totalPages)")
                        .font(.footnote)
<<<<<<< HEAD
                        .foregroundColor(Color.textSecondary)
=======
                        .foregroundColor(ThemeManager.textSecondary(for: scheme))
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f

                    Button(action: {
                        if currentPage < totalPages { currentPage += 1 }
                    }) {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(Color.gray)
<<<<<<< HEAD
                            .font(.system(size: 20))
=======
>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
                    }.buttonStyle(.plain)
                    .disabled(currentPage == totalPages)
                }
                .padding(.top, 8)
            }
        }
<<<<<<< HEAD
        .onAppear { itemsPerPage = defaultItemsPerPage }
        .background(Color.bg)
    }
}
=======
        .onAppear {
            itemsPerPage = defaultItemsPerPage
        }
        .background(ThemeManager.bg(for: scheme))
       
    }
}

//
// MARK: - Previews
//

>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
