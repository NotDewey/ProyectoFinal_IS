//
//  Item.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import Foundation

struct Item: Identifiable, Equatable {
    let id: UUID
    var title: String
    
    /// Inicio de la reserva (fecha + hora)
    var start: Date
    
    /// Duración en horas (por defecto 1h)
    var durationHours: Int = 1
    
    /// Fin calculado en base a `start` + `durationHours`
    var end: Date {
        Calendar.current.date(byAdding: .hour, value: durationHours, to: start) ?? start
    }
    
    // Init principal
    init(id: UUID = UUID(), title: String, start: Date, durationHours: Int = 1) {
        self.id = id
        self.title = title
        self.start = start
        self.durationHours = durationHours
    }
    
    // Compatibilidad con tu modelo anterior (permitía `date`)
    init(id: UUID = UUID(), title: String, date: Date) {
        self.init(id: id, title: title, start: date, durationHours: 1)
    }
    
    // (Opcional) Redondea la hora al bloque de 30 min más cercano
    mutating func roundStartToNearest30m() {
        let cal = Calendar.current
        var comps = cal.dateComponents([.year,.month,.day,.hour,.minute], from: start)
        let minute = comps.minute ?? 0
        let roundedMin = Int((Double(minute)/30.0).rounded()) * 30 % 60
        let hourCarry = minute >= 45 ? 1 : 0
        comps.minute = roundedMin
        comps.hour = (comps.hour ?? 0) + hourCarry
        self.start = cal.date(from: comps) ?? start
    }
    
    static let sample: [Item] = [
        .init(title: "Ping Pong",    start: .now,                           durationHours: 1),
        .init(title: "Basketball",   start: .now.addingTimeInterval(86400), durationHours: 2),
        .init(title: "Volleyball",   start: .now.addingTimeInterval(2*86400)),
        .init(title: "Futbol",       start: .now.addingTimeInterval(3*86400)),
        .init(title: "PC Arena",     start: .now.addingTimeInterval(4*86400))
    ]
}
