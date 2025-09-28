//
//  AuthTests.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import XCTest
@testable import AvanceProyecto

/// Tests para el sistema de autenticación usando MockAuthService
final class AuthTests: XCTestCase {
    var authService: MockAuthService!

    override func setUp() {
        super.setUp()
        authService = MockAuthService()
    }

    override func tearDown() {
        authService = nil
        super.tearDown()
    }

    // MARK: - Login válido
    func testLoginWithValidCredentials() {
        let expectation = self.expectation(description: "Login success")

        authService.login(email: "admin@mail.com", password: "1234") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.email, "admin@mail.com", "El email debería coincidir")
                XCTAssertEqual(user.role, "admin", "El rol debería ser admin")
                XCTAssertNotNil(self.authService.currentToken(), "El token debe estar disponible después de login")
            case .failure(let error):
                XCTFail("Login debería funcionar, pero falló con error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Login inválido
    func testLoginWithInvalidCredentials() {
        let expectation = self.expectation(description: "Login fail")

        authService.login(email: "wrong@mail.com", password: "badpass") { result in
            switch result {
            case .success:
                XCTFail("Login no debería funcionar con credenciales incorrectas")
            case .failure:
                XCTAssertNil(self.authService.currentToken(), "El token no debe estar disponible en login fallido")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Logout limpia token
    func testLogoutClearsToken() {
        let expectation = self.expectation(description: "Login and logout")

        authService.login(email: "admin@mail.com", password: "1234") { _ in
            XCTAssertNotNil(self.authService.currentToken(), "El token debe existir después de login")
            self.authService.logout()
            XCTAssertNil(self.authService.currentToken(), "El token debe limpiarse después de logout")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: - Decodificar rol desde un JWT mockeado
    func testDecodeRoleFromMockJWT() {
        let fakeJWT = authService.currentToken() ?? authService.loginAndReturnToken()

        XCTAssertNotNil(fakeJWT, "El mock debe generar un JWT falso")
        XCTAssertEqual(authService.currentRole(), "admin", "El rol decodificado debería ser admin")
    }
}

// MARK: - Helper para testDecodeRoleFromMockJWT
private extension MockAuthService {
    func loginAndReturnToken() -> String? {
        var token: String?
        let expectation = XCTestExpectation(description: "Login for token")

        self.login(email: "admin@mail.com", password: "1234") { _ in
            token = self.currentToken()
            expectation.fulfill()
        }

        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        return token
    }
}
