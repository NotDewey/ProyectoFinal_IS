//
//  User.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

struct User: Codable, Equatable {
    let id: UUID
    let email: String
    let role: String   // "admin" o "user"
    let token: String
}
