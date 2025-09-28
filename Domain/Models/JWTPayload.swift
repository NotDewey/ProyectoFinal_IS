//
//  JWTPayload.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-28.
//

import Foundation

struct JWTPayload: Codable {
    let id: String
    let email: String
    let role: String   // "admin" o "user"
    let exp: Int
}
