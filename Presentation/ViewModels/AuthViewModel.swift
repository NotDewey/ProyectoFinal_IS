//
//  AuthViewModel.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    private let service = AuthService()

    func login(email: String, password: String) {
        service.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                }
            }
        }
    }

    func isAdmin() -> Bool {
        return user?.role == "admin"
    }
}
