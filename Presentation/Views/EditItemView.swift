//
//  EditItemView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct EditItemView: View {
    enum Mode {
        case new
        case edit(existing: Item)
        
        var title: String {
            switch self {
            case .new:  return "Nuevo elemento"
            case .edit: return "Editar elemento"
            }
        }
    }
    
    let mode: Mode
    /// onSave ahora recibe: título, inicio (fecha+hora) y duración en horas
    var onSave: (_ title: String, _ start: Date, _ durationHours: Int) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var start: Date = .now
    @State private var durationHours: Int = 1
    
    init(
        mode: Mode,
        onSave: @escaping (_ title: String, _ start: Date, _ durationHours: Int) -> Void
    ) {
        self.mode = mode
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Título del elemento") {
                    TextField("Escribe un título", text: $title)
                        .accessibilityLabel("Campo de título")
                }
                
                Section("Fecha y hora") {
                    DatePicker(
                        "Selecciona fecha y hora",
                        selection: $start,
                        in: Date()..., // evita fechas pasadas (opcional)
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .accessibilityLabel("Selector de fecha y hora")
                }
                
                Section("Duración") {
                    Stepper(
                        "Duración: \(durationHours) h",
                        value: $durationHours,
                        in: 1...3
                    )
                    .accessibilityLabel("Selector de duración en horas")
                    
                    HStack {
                        Text("Termina:")
                        Spacer()
                        Text(
                            Calendar.current
                                .date(byAdding: .hour, value: durationHours, to: start)?
                                .formatted(date: .omitted, time: .shortened) ?? ""
                        )
                        .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(mode.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Guardar") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        onSave(title, start, durationHours)
                        dismiss()
                    }
                    .bold()
                    .accessibilityLabel("Guardar cambios")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .onAppear {
                if case let .edit(existing) = mode {
                    title          = existing.title
                    start          = existing.start
                    durationHours  = existing.durationHours
                }
            }
        }
    }
}
