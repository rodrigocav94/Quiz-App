//
//  CreateEditProfileView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct CreateEditProfileView: View {
    @StateObject private var vm = CreateEditProfileViewModel()
    @Environment(\.modelContext) var modelContext
    var profile: Profile?
    private let maxIconIndex = 17
    private let minIconIndex = 1
    
    var body: some View {
        VStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            VStack(spacing: 40) {
                Text("Mostre quem você é!")
                    .font(Font.custom("Kickers-Regular", size: 50))
                HStack {
                    arrowButton(goesToTheLeft: true)
                    
                    Image("pfp\(vm.pfpIndex)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 220)
                    
                    arrowButton(goesToTheLeft: false)
                }
                .background(
                    SpinningLight().scaleEffect(x: 2, y: 2)
                        .allowsHitTesting(false)
                )
                
                VStack {
                    TextField("Seu nome", text: $vm.name)
                        .font(Font.custom("Kickers-Regular", size: 40))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .frame(maxHeight: .infinity, alignment: .top)
                    Button("Guardar") {
                        vm.onSave(context: modelContext, profile: profile)
                    }
                    .buttonStyle(LargeButtonStyle(color: .quizGreen))
                    
                    if let profile {
                        Button("Remover") {
                            vm.onDelete(context: modelContext, profile: profile)
                        }
                        .buttonStyle(LargeButtonStyle(color: .quizPink))
                    }
                }
                .padding()
                .background(.quizOffWhite)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .padding(.horizontal, 40)
        }
        .clipped()
        .background(.quizYellow)
        .navigationBarBackButtonHidden()
        .onAppear {
            vm.updateInfo(profile: profile)
        }
    }
    
    func arrowButton(goesToTheLeft: Bool) -> some View {
        let shouldBeDisabled = vm.pfpIndex == (goesToTheLeft ? minIconIndex : maxIconIndex)
        
        return Button {
            vm.onArrowButton(goesToTheLeft)
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
