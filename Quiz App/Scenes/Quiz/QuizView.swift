//
//  QuizView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.modelContext) var modelContext
    var profile: Profile?
    @StateObject var vm = QuizViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            BackButtonAndClock
            
            HStack(spacing: 20) {
                CorrectAnswerTracker
                QuestionIndex
            }
            
            VStack(alignment: .leading, spacing: 20) {
                QuestionStatement
                QuestionOptions
            }
            .animation(.default, value: vm.currentQuestion)
            .padding(.bottom)
            .background(alignment: .topTrailing) {
                Illustration
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
            vm.discardQuestionsAndUpdateInfo(context: modelContext, profile: profile)
        }
    }
}

// MARK: - Back Button And Clock
extension QuizView {
    var Clock: some View {
        HStack(spacing: 3) {
            Image(systemName: "clock.fill")
                .foregroundStyle(.quizGreen)
            Text(vm.remainingTimeString)
                .frame(width: 40)
        }
        .capsuleViewStyle(
            fontColor: .quizOffBlack,
            borderColor: .quizOffWhite
        )
    }
    
    var BackButtonAndClock: some View {
        HStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .trailing) {
                    Clock
                }
        }
    }
}

// MARK: - Correct Answer Tracker
extension QuizView {
    var CorrectAnswerTracker: some View {
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
    }
}

// MARK: - Question Index
extension QuizView {
    var QuestionIndex: some View {
        HStack(spacing: 3) {
            ForEach(vm.questions.indices, id: \.self) { step in
                Capsule()
                    .frame(height: 4)
                    .foregroundStyle(step > vm.questionIndex ? .quizOffWhite.opacity(0.5) : .quizGreen)
            }
        }
        .animation(.default, value: vm.questionIndex)
    }
}

// MARK: - Question Statement
extension QuizView {
    var QuestionStatement: some View {
        Text(vm.currentQuestion.statement)
            .font(Font.custom("Kickers-Regular", size: 65))
            .minimumScaleFactor(0.1)
        
    }
}

// MARK: - Question Options
extension QuizView {
    var QuestionOptions: some View {
        VStack(spacing: 10) {
            ForEach(Array(vm.currentQuestion.options.enumerated()), id: \.element) { (index, element) in
                Button {
                    vm.answer(element)
                } label: {
                    Text(element)
                }
                .buttonStyle(QuizOptionButtonStyle(answer: element, selectedOption: vm.selectedOption, didAnswerCorrectly: vm.didAnswerCorrectly))
            }
        }
        .disabled(vm.selectedOption != nil)
        .layoutPriority(1)
        .transition(.slide.combined(with: .opacity))
        .id(vm.currentQuestion)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

// MARK: - Illustration
extension QuizView {
    var Illustration: some View {
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
#Preview {
    QuizView()
}
