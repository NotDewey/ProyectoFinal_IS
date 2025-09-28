//
//  DonorFormView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-27.
//

import SwiftUI

struct DonorFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DonorViewModel

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var donationAmount: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del Donador")) {
                    TextField("Nombre", text: $name)
                    TextField("Correo", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("Monto de donación", text: $donationAmount)
                        .keyboardType(.decimalPad)
                }

                Button(action: saveDonor) {
                    Text("Guardar")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Nuevo Donador")
            .navigationBarItems(trailing: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func saveDonor() {
        guard let amount = Double(donationAmount) else { return }
        let newDonor = Donor(
            id: UUID(),
            name: name,
            email: email,
            donationAmount: amount
        )
        viewModel.addDonor(newDonor)
        presentationMode.wrappedValue.dismiss()
    }
}
