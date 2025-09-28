//
//  DonorListView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import SwiftUI

struct DonorListView: View {
    @ObservedObject var viewModel: DonorViewModel

    var body: some View {
        List(viewModel.donors) { donor in
            VStack(alignment: .leading) {
                Text(donor.name).font(.headline)
                Text(donor.email).font(.subheadline)
                Text("Donación: $\(donor.donationAmount, specifier: "%.2f")")
                    .font(.caption)
            }
        }
        .navigationTitle("Donantes")
    }
}
