//
//  AuthService.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class AuthService {
    private var token: String?

    // MARK: - Guardar Token después de login
    func saveToken(_ jwt: String) {
        self.token = jwt
    }

    // MARK: - Obtener Token actual
    func currentToken() -> String? {
        return token
    }

    // MARK: - Decodificar JWT y obtener rol
    func currentRole() -> String? {
        guard let token = token else { return nil }

        let parts = token.split(separator: ".")
        guard parts.count == 3 else { return nil }

        let payloadBase64 = String(parts[1])
        guard let payloadString = payloadBase64.base64UrlDecodedString(),
              let payloadData = payloadString.data(using: .utf8) else {
            return nil
        }

        do {
            let payload = try JSONDecoder().decode(JWTPayload.self, from: payloadData)
            return payload.role
        } catch {
            print("❌ Error decoding JWT: \(error)")
            return nil
        }
    }

    // MARK: - Login (ejemplo con backend real)
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://tu-backend.com/api/login") else {
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
                self.saveToken(user.token) // ✅ guardamos el token del backend
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Logout (limpia token)
    func logout() {
        token = nil
    }
}
