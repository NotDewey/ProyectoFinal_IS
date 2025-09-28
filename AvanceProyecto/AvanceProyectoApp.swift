//
//  AvanceProyectoApp.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

@main
struct AvanceProyectoApp: App {
    @StateObject private var itemsVM = ItemsViewModel()
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            RootView(isLoggedIn: $isLoggedIn)
                .environmentObject(itemsVM)
        }
    }
}

