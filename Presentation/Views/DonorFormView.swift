//
//  DonorFormView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import SwiftUI

struct DonorFormView: View {
    @ObservedObject var viewModel: DonorViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var amount = ""

    var body: some View {
        Form {
            TextField("Nombre", text: $name)
            TextField("Correo", text: $email)
            TextField("Donación", text: $amount)
                .keyboardType(.decimalPad)

            Button("Agregar Donante") {
                if let donation = Double(amount) {
                    viewModel.addDonor(name: name, email: email, amount: donation)
                    name = ""
                    email = ""
                    amount = ""
                }
            }
        }
        .navigationTitle("Nuevo Donante")
    }
}
