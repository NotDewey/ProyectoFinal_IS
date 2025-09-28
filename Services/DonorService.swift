//
//  DonorService.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class DonorService {
    private let baseURL = "https://tu-backend.com/api/donors"   // 👉 cámbialo por tu backend real

    // Crear donante (requiere rol admin normalmente)
    func createDonor(donor: Donor, completion: @escaping (Result<Donor, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let body = try? JSONEncoder().encode(donor)

        APIClient.shared.request(
            url: url,
            method: "POST",
            body: body
        ) { (result: Result<Donor, Error>) in
            completion(result)
        }
    }

    // Obtener lista de donantes
    func getDonors(completion: @escaping (Result<[Donor], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        APIClient.shared.request(
            url: url,
            method: "GET"
        ) { (result: Result<[Donor], Error>) in
            completion(result)
        }
    }
}
