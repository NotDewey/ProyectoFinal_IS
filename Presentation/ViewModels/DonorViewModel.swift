//
//  DonorViewModel.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class DonorViewModel: ObservableObject {
    @Published var donors: [Donor] = []
    private var donorService: DonorService

    init(auth: AuthService) {
        self.donorService = DonorService(auth: auth)
    }

    func addDonor(name: String, email: String, amount: Double) {
        let donor = Donor(id: UUID(), name: name, email: email, donationAmount: amount)
        donorService.createDonor(donor: donor) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newDonor):
                    self.donors.append(newDonor)
                case .failure(let error):
                    print("Error adding donor: \(error.localizedDescription)")
                }
            }
        }
    }
}
