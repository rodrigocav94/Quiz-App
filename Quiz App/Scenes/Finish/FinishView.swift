//
//  FinishView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI
import MSwiftUINavigator

struct FinishView: View {
    @ObservedObject var vm: QuizViewModel
    @State private var displayConfetti = true
    
    var body: some View {
        VStack {
            CloseButton
            Illustration
            VStack(spacing: 35) {
                Header
                BottomButtons
            }
            .padding(.horizontal, 40)
        }
        .padding(.bottom)
        .background(
            Color.quizGreen
                .ignoresSafeArea(.all)
        )
        .displayConfetti(isActive: $displayConfetti)
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Close Button
extension FinishView {
    var CloseButton: some View {
        Button {
            NavigationManager.shared.popToRootView()
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(CircleBarButtonStyle())
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
    }
}

// MARK: - Illustration
extension FinishView {
    var Illustration: some View {
        Image("finish-background")
            .resizable()
            .scaledToFit()
            .background {
                SpinningLight()
            }
    }
}

// MARK: - Header
extension FinishView {
    var Header: some View {
        VStack(spacing: 15) {
            Text("Parabéns!\nVocê mandou bem!")
                .font(Font.custom("Kickers-Regular", size: 60))
                .minimumScaleFactor(0.1)
            
            Text("Esperamos que tenha curtido o resultado e aprendido algo novo!")
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.quizOffWhite)
    }
}

// MARK: - Bottom Buttons
extension FinishView {
    var BottomButtons: some View {
        HStack {
            bottomButtonLabel(text: "\(vm.score)", systemIcon: "", title: "Acertos", color: .quizOffWhite)
            
            Button {
                vm.restartQuiz()
                NavigationManager.shared.popView()
            } label: {
                bottomButtonLabel(systemIcon: "arrow.clockwise", title: "Reiniciar", color: .quizPink)
            }
            
            ShareLink(item: "Consegui acertar \(vm.score) perguntas no Quiz App! E você, quantas consegue?") {
                bottomButtonLabel(systemIcon: "paperplane.fill", title: "Compartilhar", color: .quizYellow)
            }
        }
    }
    
    func bottomButtonLabel(text: String? = nil, systemIcon: String, title: String, color: Color) -> some View {
        VStack {
            Group {
                if let text {
                    Text(text)
                        .font(Font.custom("Kickers-Regular", size: 30))
                } else {
                    Image(systemName: systemIcon)
                        .font(.title2)
                        .fontWeight(.black)
                }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(.quizOffBlack)
            
            Text(title)
                .foregroundStyle(.quizOffWhite)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
        }
    }
}

#Preview {
    FinishView(vm: QuizViewModel())
}
