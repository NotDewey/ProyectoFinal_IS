//
//  MockAuthService.swift
//  AvanceProyectoTests
//
//  Created by David Moreno on 2025-09-28.
//

import Foundation
@testable import AvanceProyecto

class MockAuthService: AuthService {
    private var mockToken: String?

    override func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Simulación de credenciales válidas
        if email == "admin@mail.com" && password == "1234" {
            let fakeToken = generateFakeJWT(role: "admin")
            let user = User(
                id: UUID(),
                email: email,
                role: "admin",
                token: fakeToken
            )
            self.mockToken = fakeToken
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "Invalid credentials", code: 401)))
        }
    }

    override func currentToken() -> String? {
        return mockToken
    }

    override func currentRole() -> String? {
        return decodeRole(from: mockToken)
    }

    override func logout() {
        mockToken = nil
    }

    // MARK: - Helpers
    private func generateFakeJWT(role: String) -> String {
        let header = ["alg": "HS256", "typ": "JWT"]
        let payload = [
            "id": UUID().uuidString,
            "email": "admin@mail.com",
            "role": role,
            "exp": Int(Date().addingTimeInterval(3600).timeIntervalSince1970)
        ] as [String : Any]

        func encodeToBase64URL(_ json: [String: Any]) -> String {
            let data = try! JSONSerialization.data(withJSONObject: json, options: [])
            var base64 = data.base64EncodedString()
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "=", with: "")
            return base64
        }

        let headerBase64 = encodeToBase64URL(header)
        let payloadBase64 = encodeToBase64URL(payload)
        return "\(headerBase64).\(payloadBase64).signature"
    }

    private func decodeRole(from token: String?) -> String? {
        guard let token = token else { return nil }
        let parts = token.split(separator: ".")
        guard parts.count == 3 else { return nil }

        let payloadBase64 = String(parts[1])
        guard let payloadString = payloadBase64.base64UrlDecodedString(),
              let payloadData = payloadString.data(using: .utf8) else {
            return nil
        }

        let payload = try? JSONDecoder().decode(JWTPayload.self, from: payloadData)
        return payload?.role
    }
}

extension String {
    func base64UrlDecodedString() -> String? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let paddingLength = 4 - base64.count % 4
        if paddingLength < 4 {
            base64 += String(repeating: "=", count: paddingLength)
        }

        guard let data = Data(base64Encoded: base64) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

struct JWTPayload: Codable {
    let id: String
    let email: String
    let role: String
    let exp: Int
}

