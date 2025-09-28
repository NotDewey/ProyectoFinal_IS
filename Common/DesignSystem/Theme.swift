//
//  Theme.swift
//  AvanceProyecto
//
//  Created by David Moreno on 2025-09-01.
//

import SwiftUI

enum DS {
    static let corner: CGFloat = 14
    static let padding: CGFloat = 16
}

extension Color {
    static let tecmilenioGreen = Color(red: 0/255, green: 95/255, blue: 86/255)
}


struct PrimaryButton: ViewModifier {
    func body(content: Content) -> some View {   // <-- importantísimo: Content
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.tecmilenioGreen)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: DS.corner, style: .continuous))
            .accessibilityAddTraits(.isButton)
    }
}

extension View {
    func primaryButton() -> some View { modifier(PrimaryButton()) }

    func framedField() -> some View {
        self.padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: DS.corner, style: .continuous)
                    .stroke(.secondary, lineWidth: 1.2)
            )
    }
}
