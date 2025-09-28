//
//  Donor.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

struct Donor: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var donationAmount: Double
}
