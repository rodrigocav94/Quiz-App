//
//  LargeButtonStyle.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    var color: Color = .quizOffBlack
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Kickers-Regular", size: 30))
            .foregroundStyle(.white)
            .frame(height: 65)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(.capsule)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .opacity(isEnabled ? 1 : 0.5)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .animation(.default, value: isEnabled)
    }
}
