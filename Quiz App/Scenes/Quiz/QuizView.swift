//
//  QuizView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct QuizView: View {
    @StateObject var vm = QuizViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                BackButton()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        HStack(spacing: 3) {
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.quizGreen)
                            Text(vm.remainingTimeString)
                                .frame(width: 34)
                        }
                        .frame(maxHeight: .infinity)
                        .bold()
                        .padding(.horizontal, 20)
                        .overlay(Capsule().stroke(.quizOffWhite, lineWidth: 2))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
            }
            
            HStack(spacing: 20) {
                HStack(spacing: 3) {
                    Image(systemName: "checkmark.seal.fill")
                    Text("\(vm.score)")
                }
                .bold()
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
                .background {
                    Capsule()
                        .fill(.quizGreen)
                }
                .foregroundStyle(.white)
                
                HStack(spacing: 3) {
                    ForEach(vm.questions.indices, id: \.self) { step in
                        Capsule()
                            .frame(height: 4)
                            .foregroundStyle(step > vm.questionIndex ? .quizOffWhite.opacity(0.5) : .quizGreen)
                    }
                }
                .animation(.default, value: vm.questionIndex)
            }
            
            VStack(alignment: .leading, spacing: 40) {
                Text(vm.currentQuestion.statement)
                    .font(Font.custom("Kickers-Regular", size: 65))
                    .minimumScaleFactor(0.1)
                
                VStack(spacing: 10) {
                    ForEach(Array(vm.currentQuestion.options.enumerated()), id: \.element) { (index, element) in
                        Text(element)
                            .font(Font.custom("Kickers-Regular", size: 25))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.6)
                            .foregroundStyle(getOptionFontColor(element))
                            .frame(maxWidth: .infinity)
                            .padding( 15)
                            .background {
                                Capsule()
                                    .fill(getOptionBackgroundColor(element))
                            }
                            .onTapGesture {
                                vm.answer(element)
                            }
                    }
                }
                .layoutPriority(1)
                .transition(.slide.combined(with: .opacity))
                .id(vm.currentQuestion)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .animation(.default, value: vm.currentQuestion)
            .padding(.bottom)
            .background(alignment: .topTrailing) {
                Image("quiz-background")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                    .offset(x: 40)
            }
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.quizPink)
        .navigationBarBackButtonHidden()
        .alert(isPresented: $vm.displayingAlert) {
            Alert(
                title: Text("Algo deu errado ao enviar sua resposta."),
                message: Text("Tente de novo!")
            )
        }
        .onAppear {
            vm.discardQuestions()
        }
    }
    
    func getOptionBackgroundColor(_ answer: String) -> Color {
        guard let selectedOption = vm.selectedOption, let isCorrect = vm.didAnswerCorrectly else {
            return .quizOffWhite
        }
        
        if answer == selectedOption {
            return isCorrect ? .quizGreen : .quizOffBlack
        }
        
        return .quizOffWhite
    }
    
    func getOptionFontColor(_ answer: String) -> Color {
        return answer == vm.selectedOption && vm.didAnswerCorrectly != nil ? .white : .quizOffBlack
    }
}

#Preview {
    QuizView()
}
