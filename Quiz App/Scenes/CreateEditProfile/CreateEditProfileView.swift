//
//  CreateEditProfileView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct CreateEditProfileView: View {
    @Environment(\.keyboardShowing) var keyboardShowing
    @FocusState private var textFieldIsFocused: Bool
    @ObservedObject var homeVM: HomeViewModel
    @StateObject private var vm = CreateEditProfileViewModel()
    @Environment(\.modelContext) var modelContext
    var profile: Profile?
    private let maxIconIndex = 17
    private let minIconIndex = 1
    
    var body: some View {
        VStack(spacing: 0) {
            if !keyboardShowing {
                Header
                ProfileIconSelection
            }
            TextFieldAndButton
        }
        .padding(.horizontal, 40)
        .padding(.bottom)
        .animation(.default, value: keyboardShowing)
        .frame(maxHeight: .infinity)
        .background(.quizYellow)
        .safeAreaInset(edge: .top) {
            BackButtonAndDelete
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            vm.updateInfo(profile: profile)
        }
        .alert(isPresented: $vm.displayingAlert) {
            Alert(
                title: Text("Ops! Não conseguimos salvar suas informações."),
                message: Text("Por favor, insira um nome para continuar.")
            )
        }
    }
}

// MARK: - Header
extension CreateEditProfileView {
    var Header: some View {
        Text("Mostre quem você é!")
            .font(Font.custom("Kickers-Regular", size: 50))
            .multilineTextAlignment(.center)
    }
}

// MARK: - Profile Icon Selection
extension CreateEditProfileView {
    var ProfileIconSelection: some View {
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
        .frame(maxHeight: .infinity)
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

// MARK: - Name TextField And Save Button
extension CreateEditProfileView {
    var TextFieldAndButton: some View {
        VStack {
            TextField("Seu Nome", text: $vm.name)
                .font(Font.custom("Kickers-Regular", size: 40))
                .multilineTextAlignment(.center)
                .lineLimit(0)
                .focused($textFieldIsFocused)
            
            Button(keyboardShowing ? "Voltar" : "Guardar") {
                if keyboardShowing {
                    textFieldIsFocused = false
                } else {
                    vm.onSave(context: modelContext, profile: profile)
                }
            }
            .buttonStyle(LargeButtonStyle(color: .quizGreen))
        }
        .padding()
        .background(.quizOffWhite)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

// MARK: - Back Button And Delete
extension CreateEditProfileView {
    var BackButtonAndDelete: some View {
        BackButton()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .overlay(alignment: .trailing) {
                if let profile {
                    Button{
                        vm.onDelete(context: modelContext, profile: profile, homeVM: homeVM)
                    } label: {
                        Text("Remover")
                            .capsuleViewStyle(fontColor: .quizOffBlack, borderColor: .red)
                    }
                    .padding(.trailing)
                }
            }
    }
}

#Preview {
    CreateEditProfileView(homeVM: HomeViewModel())
}
