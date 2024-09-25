//
//  CreateEditProfileView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct CreateEditProfileView: View {
    @State private var pfpIndex = 1
    @State private var name = ""
    
    var body: some View {
        VStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 40) {
                Text("Mostre quem você é!")
                    .font(Font.custom("Kickers-Regular", size: 50))
                HStack {
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.largeTitle)
                    
                    Image("pfp\(pfpIndex)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 220)
                    
                    Image(systemName: "arrowshape.right.fill")
                        .font(.largeTitle)
                }
                
                VStack {
                    TextField("Seu nome", text: $name)
                        .font(Font.custom("Kickers-Regular", size: 40))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .frame(maxHeight: .infinity, alignment: .top)
                    Button("Salvar") {}
                        .buttonStyle(LargeButtonStyle(color: .quizPink))
                }
                .padding()
                .background(.quizOffWhite)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .frame(maxHeight: .infinity, alignment: . top)
            .padding(.horizontal, 40)
        }
        .background(.quizYellow)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateEditProfileView()
}
