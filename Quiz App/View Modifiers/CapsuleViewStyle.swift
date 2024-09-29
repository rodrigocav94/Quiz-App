//
//  CapsuleViewStyle.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import SwiftUI

extension View {
    func capsuleViewStyle(fontColor: Color, borderColor: Color) -> some View {
        self
            .frame(maxHeight: .infinity)
            .bold()
            .padding(.horizontal, 20)
            .overlay(Capsule().stroke(borderColor, lineWidth: 2))
            .foregroundStyle(fontColor)
    }
}
