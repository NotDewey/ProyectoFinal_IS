//
//  DonorService.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class DonorService {
    private var donors: [Donor] = []

    init() {
        self.donors = [
            Donor(id: UUID(), name: "Mateo", email: "mateo@mail.com", donationAmount: 200.0),
            Donor(id: UUID(), name: "Ana", email: "ana@mail.com", donationAmount: 150.0)
        ]
    }

    func fetchDonors(completion: @escaping (Result<[Donor], Error>) -> Void) {
        completion(.success(donors))
    }

    func createDonor(donor: Donor, completion: @escaping (Result<Donor, Error>) -> Void) {
        donors.append(donor)
        completion(.success(donor))
    }

    func deleteDonor(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        if let index = donors.firstIndex(where: { $0.id == id }) {
            donors.remove(at: index)
            completion(.success(()))
        } else {
            let error = NSError(
                domain: "DonorService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Donor not found"]
            )
            completion(.failure(error))
        }
    }
}
