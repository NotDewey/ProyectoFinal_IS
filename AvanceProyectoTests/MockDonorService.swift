import Foundation
@testable import AvanceProyecto

class MockDonorService: DonorServiceProtocol {
    private var mockDonors: [Donor] = [
        Donor(id: UUID(), name: "TestUser1", email: "test1@mail.com", donationAmount: 100),
        Donor(id: UUID(), name: "TestUser2", email: "test2@mail.com", donationAmount: 200)
    ]
    
    func fetchDonors(completion: @escaping (Result<[Donor], Error>) -> Void) {
        completion(.success(mockDonors))
    }
    
    func createDonor(donor: Donor, completion: @escaping (Result<Donor, Error>) -> Void) {
        mockDonors.append(donor)
        completion(.success(donor))
    }
    
    func deleteDonor(id: UUID, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let index = mockDonors.firstIndex(where: { $0.id == id }) {
            mockDonors.remove(at: index)
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "MockDonorService", code: 404)))
        }
    }
}

