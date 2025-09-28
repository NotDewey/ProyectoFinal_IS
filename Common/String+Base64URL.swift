//
//  String+Base64URL.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-28.
//

import Foundation

extension String {
    func base64UrlDecodedData() -> Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        // Ajustar padding
        while base64.count % 4 != 0 {
            base64.append("=")
        }

        return Data(base64Encoded: base64)
    }

    func base64UrlDecodedString() -> String? {
        guard let data = base64UrlDecodedData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

