//
//  HomeView.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var itemsVM: ItemsViewModel
    @State private var showingAdd = false
    let onLogout: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Servicios")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 20)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.tecmilenioGreen)

                List {
                    ForEach(itemsVM.items) { item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            Text(item.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 14)
                        }
                        .listRowInsets(EdgeInsets())
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.corner)
                                .stroke(.secondary, lineWidth: 1.2)
                        )
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.plain)
                
                Button {
                    showingAdd = true
                } label: {
                    Label("+ Agregar", systemImage: "plus")
                        .frame(maxWidth: 280)
                }
                .primaryButton()
                .accessibilityLabel("Agregar elemento")
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Salir") { onLogout() }
                }
            }
            .sheet(isPresented: $showingAdd) {
                EditItemView(mode: .new) { title, start, duration in
                    itemsVM.add(title: title, start: start, durationHours: duration)
                }
            }
        }
    }
}
