//
//  AuthService.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class AuthService {
    private let baseURL = "https://tu-backend.com/api"   // 👉 cámbialo por tu backend real

    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let body = try? JSONEncoder().encode(["email": email, "password": password])

        APIClient.shared.request(
            url: url,
            method: "POST",
            body: body
        ) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                APIClient.shared.setToken(user.token) // Guardar token globalmente
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Obtener Token
    func getToken() -> String? {
        return APIClient.shared.token
    }
}

