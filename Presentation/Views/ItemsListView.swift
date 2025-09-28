//
//  ItemsListView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct ItemsListView: View {
    @StateObject private var vm = ItemsViewModel()
    @State private var showingAdd = false
    @State private var selectedItem: Item? = nil   // para editar

    var body: some View {
        NavigationStack {
            List(vm.items) { item in     // <- sin $
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title).font(.headline)
                        Text(item.start.formatted(date: .abbreviated, time: .shortened))
                        Text("Termina: \(item.end.formatted(date: .omitted, time: .shortened))")
                            .font(.footnote).foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .contentShape(Rectangle())       // para que el tap agarre toda la fila
                .onTapGesture {                  // editar
                    selectedItem = item
                }
            }
            .navigationTitle("Reservas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true        // crear nuevo
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Crear nuevo
            .sheet(isPresented: $showingAdd) {
                EditItemView(mode: .new) { title, start, duration in
                    vm.add(title: title, start: start, durationHours: duration)
                }
            }
            // Editar existente
            .sheet(item: $selectedItem) { item in
                EditItemView(mode: .edit(existing: item)) { title, start, duration in
                    vm.update(item, title: title, start: start, durationHours: duration)
                }
            }
        }
    }
}
