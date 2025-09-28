//
//  DonorTests.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import XCTest
@testable import AvanceProyecto

final class DonorTests: XCTestCase {
    func testDonorModelInitialization() {
        let donor = Donor(id: UUID(), name: "Mateo", email: "mateo@mail.com", donationAmount: 200.0)
        XCTAssertEqual(donor.name, "Mateo")
        XCTAssertEqual(donor.email, "mateo@mail.com")
        XCTAssertEqual(donor.donationAmount, 200.0)
    }

    func testUserRole() {
        let user = User(id: UUID(), email: "admin@mail.com", role: "admin", token: "fakeToken")
        XCTAssertEqual(user.role, "admin")
    }
}
