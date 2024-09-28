//
//  CreateEditProfileView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct CreateEditProfileView: View {
    @State private var pfpIndex = Int.random(in: 1...17)
    @State private var name = ""
    
    var body: some View {
        VStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 40) {
                Text("Mostre quem você é!")
                    .font(Font.custom("Kickers-Regular", size: 50))
                HStack {
                    arrowButton(goesToTheLeft: true)
                    
                    Image("pfp\(pfpIndex)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 220)
                    
                    arrowButton(goesToTheLeft: false)
                }
                
                VStack {
                    TextField("Seu nome", text: $name)
                        .font(Font.custom("Kickers-Regular", size: 40))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .frame(maxHeight: .infinity, alignment: .top)
                    Button("Guardar") {}
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
    
    func arrowButton(goesToTheLeft: Bool) -> some View {
        let shouldBeDisabled = pfpIndex == (goesToTheLeft ? 1 : 17)
        
        return Button {
            if goesToTheLeft {
                if pfpIndex > 1 {
                    pfpIndex -= 1
                }
            } else {
                if pfpIndex < 17 {
                    pfpIndex += 1
                }
            }
        } label: {
            Image(systemName: goesToTheLeft ? "arrowshape.backward.fill" : "arrowshape.right.fill")
                .font(.largeTitle)
                .foregroundStyle(.quizOffBlack)
        }
        .opacity(shouldBeDisabled ? 0.5 : 1)
        .disabled(shouldBeDisabled)
    }
}

#Preview {
    CreateEditProfileView()
}
