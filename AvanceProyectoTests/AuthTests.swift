//
//  AuthTests.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import XCTest
@testable import AvanceProyecto

final class AuthTests: XCTestCase {
    
    func testUserInitialization() {
        let user = User(
            id: UUID(),
            email: "test@mail.com",
            role: "admin",
            token: "fakeToken123"
        )

        XCTAssertEqual(user.email, "test@mail.com")
        XCTAssertEqual(user.role, "admin")
        XCTAssertEqual(user.token, "fakeToken123")
    }
    
    func testAuthServiceTokenStorage() {
        let service = AuthService()
        
        // Forzamos manualmente un token para probar
        service.login(email: "demo@mail.com", password: "1234") { _ in }
        
        // En este punto el token se setearía cuando haya login real
        XCTAssertNil(service.currentToken(), "El token debería ser nil sin un login real")
    }
}

