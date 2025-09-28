//
//  JWTUtils.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-28.
//

import Foundation

// MARK: - Extensión para decodificar Base64URL (formato JWT)
extension String {
    /// Convierte un string Base64URL a String normal
    func base64UrlDecodedString() -> String? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        // Ajustar padding
        while base64.count % 4 != 0 {
            base64 += "="
        }

        guard let data = Data(base64Encoded: base64) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
