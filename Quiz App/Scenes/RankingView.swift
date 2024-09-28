//
//  RankingView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        VStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ScrollView(.vertical) {
                LazyVStack {
                    Image("ranking-background")
                        .resizable()
                        .scaledToFit()
                        .background(
                            SpinningLight()
                        )
                    Text("Hall da Fama")
                        .font(Font.custom("Kickers-Regular", size: 55))
                    Text("Descubra quem brilhou no quiz!")
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 20) {
                        Image("pfp3")
                            .resizable()
                            .scaledToFit()
                        Text("Rodrigo")
                            .font(Font.custom("Kickers-Regular", size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("10 acertos")
                            .font(Font.custom("Kickers-Regular", size: 25))
                    }
                    .padding(.trailing)
                    .frame(height: 50)
                    .background(Capsule().stroke(.quizOffWhite, lineWidth: 2))
                }
                .padding([.horizontal, .bottom])
            }
            .mask(gradientMask)
        }
        .foregroundStyle(.quizOffWhite)
        .background(.quizGreen)
        .navigationBarBackButtonHidden()
    }
    
    var gradientMask: some View {
        LinearGradient(
            stops: [
                .init(color: .clear, location: 0),
                .init(color: .black, location: 0.04),
                .init(color: .black, location: 0.96),
                .init(color: .clear, location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    RankingView()
}
