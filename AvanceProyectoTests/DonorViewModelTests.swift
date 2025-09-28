//
//  DonorViewModelTests.swift
//  AvanceProyectoTests
//
//  Created by David Moreno on 2025-09-28.
//

import XCTest
@testable import AvanceProyecto

final class DonorViewModelTests: XCTestCase {
    var viewModel: DonorViewModel!

    override func setUp() {
        super.setUp()
        // Usamos el MockDonorService para pruebas
        let mockService = MockDonorService()
        viewModel = DonorViewModel(donorService: mockService)

        // 🔹 Forzar fetch y esperar a que termine
        let expectation = self.expectation(description: "Load donors")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchDonorsLoadsMockData() {
        XCTAssertEqual(viewModel.donors.count, 2)
        XCTAssertEqual(viewModel.donors.first?.name, "TestUser1")
    }

    func testAddDonorIncreasesCount() {
        let newDonor = Donor(id: UUID(), name: "Nuevo", email: "nuevo@mail.com", donationAmount: 300)

        viewModel.addDonor(newDonor)

        let expectation = self.expectation(description: "Add donor")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.donors.count, 3)
            XCTAssertTrue(self.viewModel.donors.contains { $0.name == "Nuevo" })
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveDonorDecreasesCount() {
        guard let firstDonor = viewModel.donors.first else {
            XCTFail("No donors available to remove")
            return
        }
        let initialCount = viewModel.donors.count

        viewModel.removeDonor(at: IndexSet(integer: 0))

        let expectation = self.expectation(description: "Remove donor")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.donors.count, initialCount - 1)
            XCTAssertFalse(self.viewModel.donors.contains { $0.id == firstDonor.id })
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
