//
//  DetailView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var itemsVM: ItemsViewModel
    let item: Item
    @State private var showingEdit = false

    var body: some View {
        VStack(spacing: 28) {
            Text("Detalle")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 24)
                .accessibilityAddTraits(.isHeader)
                .foregroundColor(.tecmilenioGreen)

            Group {
                Text(item.title)
                    .frame(maxWidth: .infinity)
                    .framedField() // <- si es tu modificador custom, déjalo
                    .accessibilityLabel("Título del elemento: \(item.title)")

                Text(item.start.formatted(date: .abbreviated, time: .omitted))
                    .frame(maxWidth: .infinity)
                    .framedField()
                    .accessibilityLabel("Fecha: \(item.start.formatted(date: .complete, time: .omitted))")

                Text("Hora: \(item.start.formatted(date: .omitted, time: .shortened))  ·  Termina: \(item.end.formatted(date: .omitted, time: .shortened))")
                    .frame(maxWidth: .infinity)
                    .framedField()
                    .accessibilityLabel("Hora de inicio \(item.start.formatted(date: .omitted, time: .shortened)). Termina \(item.end.formatted(date: .omitted, time: .shortened))")
            }
            .padding(.horizontal, 28)

            Spacer(minLength: 20)

            Button("Editar") { showingEdit = true }
                .primaryButton()              // <- tu estilo custom si existe
                .padding(.horizontal, 120)
                .accessibilityLabel("Editar elemento")

            Spacer()
        }
        .sheet(isPresented: $showingEdit) {
            EditItemView(mode: .edit(existing: item)) { title, start, duration in
                itemsVM.update(item, title: title, start: start, durationHours: duration)
            }
        }
    }
}
