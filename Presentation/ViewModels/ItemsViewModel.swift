//
//  ItemsViewModel.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import Foundation

@MainActor
final class ItemsViewModel: ObservableObject {
    @Published var items: [Item] = Item.sample

    // Nuevo: usa start y duración
    func add(title: String, start: Date, durationHours: Int = 1) {
        items.append(Item(id: UUID(), title: title, start: start, durationHours: durationHours))
    }

    func update(_ item: Item, title: String, start: Date, durationHours: Int? = nil) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx].title = title
        items[idx].start = start
        if let d = durationHours { items[idx].durationHours = d }
    }
}
