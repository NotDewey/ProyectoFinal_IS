//
//  DonorViewModel.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import Foundation

class DonorViewModel: ObservableObject {
    @Published var donors: [Donor] = []
    private let donorService: DonorServiceProtocol   // ✅ ahora usa el protocolo

    // ✅ Inyección de dependencias con valor por defecto
    init(donorService: DonorServiceProtocol = DonorService()) {
        self.donorService = donorService
        fetchDonors()
    }

    func fetchDonors() {
        donorService.fetchDonors { result in
            switch result {
            case .success(let donors):
                DispatchQueue.main.async {
                    self.donors = donors
                }
            case .failure(let error):
                print("❌ Error fetching donors: \(error.localizedDescription)")
            }
        }
    }

    func addDonor(_ donor: Donor) {
        donorService.createDonor(donor: donor) { result in
            switch result {
            case .success(let newDonor):
                DispatchQueue.main.async {
                    self.donors.append(newDonor)
                }
            case .failure(let error):
                print("❌ Error adding donor: \(error.localizedDescription)")
            }
        }
    }

    func removeDonor(at offsets: IndexSet) {
        for index in offsets {
            let donor = donors[index]
            donorService.deleteDonor(id: donor.id) { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.donors.remove(atOffsets: offsets)
                    }
                case .failure(let error):
                    print("❌ Error deleting donor: \(error.localizedDescription)")
                }
            }
        }
    }
}
