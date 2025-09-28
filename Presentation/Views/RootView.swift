//
//  RootView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct RootView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        if isLoggedIn {
            HomeView(onLogout: { isLoggedIn = false })
        } else {
            LoginView(onLogin: { isLoggedIn = true })
        }
    }
}
