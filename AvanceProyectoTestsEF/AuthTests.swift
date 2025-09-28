//
//  AuthTests.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class AuthService {
    private let baseURL = "https://tu-backend.com/api"   // Cambia por tu backend real
    private var token: String?

    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(["email": email, "password": password])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.token = user.token
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Obtener Token
    func getToken() -> String? {
        return token
    }

    // MARK: - Verificar Rol
    func currentRole() -> String? {
        // Si quieres decodificar el JWT para leer el rol:
        // Aquí podrías parsear el payload del token.
        // De momento usamos el user.role que viene en el JSON.
        return nil
    }
}
