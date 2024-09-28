//
//  SpinningLight.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct SpinningLight: View {
    @State private var rotationDegrees = 0.0
    
    private var animation: Animation {
        .linear
        .speed(0.03)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image("flash-light")
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(rotationDegrees))
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(animation) {
                        rotationDegrees = 360.0
                    }
                }
            }
    }
}

#Preview {
    SpinningLight()
        .background {
            Color.quizOffBlack
        }
}
