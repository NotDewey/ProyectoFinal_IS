//
//  DonorListView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import SwiftUI

struct DonorListView: View {
    @StateObject private var viewModel = DonorViewModel()
    @State private var showingForm = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.donors) { donor in
                    VStack(alignment: .leading) {
                        Text(donor.name)
                            .font(.headline)
                        Text(donor.email)
                            .font(.subheadline)
                        Text("Donación: $\(donor.donationAmount, specifier: "%.2f")")
                            .font(.footnote)
                    }
                }
                .onDelete(perform: viewModel.removeDonor)
            }
            .navigationTitle("Donadores")
            .navigationBarItems(trailing: Button(action: {
                showingForm = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingForm) {
                DonorFormView(viewModel: viewModel)
            }
        }
    }
}
