//
//  MockAuthService.swift
//  AvanceProyectoTests
//
//  Created by David Moreno on 2025-09-28.
//

import Foundation
@testable import AvanceProyecto

/// Mock del AuthService para pruebas unitarias.
/// Simula respuestas de login/logout sin necesidad de un backend real.
class MockAuthService: AuthService {
    private var simulatedToken: String?

    override func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // ✅ Simulamos credenciales válidas
        if email == "admin@mail.com" && password == "1234" {
            let mockUser = User(
                id: UUID(),
                email: email,
                role: "admin",
                token: "mocked_token_123"
            )
            simulatedToken = mockUser.token
            completion(.success(mockUser))
        } else {
            // ❌ Simulamos error de credenciales inválidas
            completion(.failure(NSError(domain: "InvalidCredentials", code: 401)))
        }
    }

    override func currentToken() -> String? {
        return simulatedToken
    }

    override func logout() {
        simulatedToken = nil
    }
}
