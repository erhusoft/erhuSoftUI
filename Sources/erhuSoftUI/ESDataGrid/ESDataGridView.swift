//
//  ESDataGridView.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI

// MARK: - SortDirection
public enum SortDirection {
    case ascending
    case descending

    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}

// MARK: - SortableHeader
public struct SortableHeader: View {
    @Environment(\.colorScheme) private var scheme
    
    let title: String
    let isActive: Bool
    let direction: SortDirection?
    let action: () -> Void

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
                .foregroundColor(ThemeManager.textPrimary(for: scheme))
            if isActive, let direction {
                Image(systemName: direction == .ascending ? "arrow.up" : "arrow.down")
                    .foregroundColor(direction == .ascending ? ThemeManager.success(for: scheme) : ThemeManager.danger(for: scheme))
                    .font(.caption2)
            }
        }
        .onTapGesture { action() }
    }
}

// MARK: - ESDataGridView
public struct ESDataGridView<Header: View, Content: View, Item: Identifiable & Equatable>: View {
    @Environment(\.colorScheme) private var scheme
    
    var items: [Item]
    var rowHeight: CGFloat = 35
    var defaultItemsPerPage: Int? = nil

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
    @State private var lastItemCount: Int = 0

    private var sortedItems: [Item] {
        guard let sort, let key = activeSortKey, isSorted else { return items }
        return items.sorted { sort($0, $1, sortDirection, key) }
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

    public init(
        items: [Item],
        rowHeight: CGFloat = 35,
        defaultItemsPerPage: Int? = nil,
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
        self.header = header
        self.rowContent = rowContent
        self.sort = sort
        self._selection = selection
    }

    public var body: some View {
        VStack(spacing: 0) {
            header({ key, dir in
                sortDirection = dir
                activeSortKey = key
                isSorted = true
                currentPage = 1
            }, activeSortKey, isSorted ? sortDirection : nil)
                .frame(height: rowHeight)
                .background(ThemeManager.bar(for: scheme))
                .foregroundColor(ThemeManager.textPrimary(for: scheme))

            Divider()

            if items.isEmpty {
                VStack {
                    Image(systemName: "tray.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No hay datos para mostrar")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textSecondary(for: scheme))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ThemeManager.bg(for: scheme))
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(paginatedItems.enumerated()), id: \.offset) { index, item in
                            rowContent(index, item)
                                .frame(height: rowHeight)
                                .background(index.isMultiple(of: 2)
                                            ? ThemeManager.row(for: scheme)
                                            : ThemeManager.bg(for: scheme))
                                .contentShape(Rectangle())
                                .onTapGesture { selection = index }
                        }
                    }
                }
            }

            if defaultItemsPerPage != nil {
                HStack(spacing: 12) {
                    Spacer()
                    Button(action: {
                        if currentPage > 1 { currentPage -= 1 }
                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                    .buttonStyle(.plain)
                    .disabled(currentPage == 1)

                    Text("Página \(currentPage) de \(totalPages)")
                        .font(.footnote)
                        .foregroundColor(ThemeManager.textSecondary(for: scheme))

                    Button(action: {
                        if currentPage < totalPages { currentPage += 1 }
                    }) {
                        Image(systemName: "chevron.forward.circle.fill")
                            .foregroundColor(Color.gray)
                    }.buttonStyle(.plain)
                    .disabled(currentPage == totalPages)
                }
                .padding(.top, 8)
            }
        }
        .onAppear {
            itemsPerPage = defaultItemsPerPage
        }
        .background(ThemeManager.bg(for: scheme))
       
    }
}

//
// MARK: - Previews
//

