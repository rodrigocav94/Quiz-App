//
//  FinishView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct FinishView: View {
    var body: some View {
        VStack {
            Button {

            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(CircleBarButtonStyle())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Image("finish-background")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 35) {
                VStack(spacing: 15) {
                    Text("Parabéns!\nVocê mandou bem!")
                        .font(Font.custom("Kickers-Regular", size: 60))
                        .minimumScaleFactor(0.1)
                    
                    Text("Esperamos que você tenha curtido o resultado e aprendido algo novo!")
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(.quizOffWhite)
                
                HStack {
                    VStack {
                        Text("9")
                            .font(Font.custom("Kickers-Regular", size: 30))
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.quizOffWhite)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        Text("Acertos")
                            .foregroundStyle(.quizOffWhite)
                    }
                    
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.title2)
                            .fontWeight(.black)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.quizPink   )
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        Text("Início")
                            .foregroundStyle(.quizOffWhite)
                    }
                    
                    VStack {
                        Image(systemName: "paperplane.fill")
                            .font(.title2)
                            .fontWeight(.black)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.quizYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        Text("Compartilhar")
                            .foregroundStyle(.quizOffWhite)
                    }
                }
            }
            .padding(.horizontal, 40)
        }
        .padding(.bottom)
        .background(
            Color.quizGreen
                .ignoresSafeArea(.all)
        )
    }
}

#Preview {
    FinishView()
}
