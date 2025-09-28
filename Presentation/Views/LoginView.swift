//
//  LoginView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct LoginView: View {
    @State private var username = "AL03081455@tecmilenio.mx"
    @State private var password = "D@megar8563##"
    let onLogin: () -> Void
    
    var body: some View {
        VStack(spacing: 28) {
            Text("SpotTime")
                .font(.system(size: 36, weight: .bold))
                .padding(.top, 40)
                .accessibilityAddTraits(.isHeader)
                .foregroundColor(.tecmilenioGreen)
            
            // Logo (opcional): usa una imagen en Assets llamada "Logo"
            Image("tecmi")   // usa el nombre que le pusiste en Assets
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120) // ajusta el tamaño a tu gusto
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)) // opcional
                .shadow(radius: 5) // opcional
                .accessibilityLabel("Logo de la aplicación")

            VStack(spacing: 18) {
                TextField("Usuario", text: $username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .framedField()
                    .accessibilityLabel("Campo de usuario")
                
                SecureField("Contraseña", text: $password)
                    .framedField()
                    .accessibilityLabel("Campo de contraseña")
            }
            .padding(.horizontal, 32)
            
            Button("Ingresar") {
                // Lógica simple: permitir si ambos campos no están vacíos
                guard !username.isEmpty, !password.isEmpty else { return }
                onLogin()
            }
            .primaryButton()
            .padding(.horizontal, 80)
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.vertical, 24)
    }
}
