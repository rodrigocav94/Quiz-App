//
//  QuizOptionButtonStyle.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import SwiftUI

struct QuizOptionButtonStyle: ButtonStyle {
    var answer: String
    var selectedOption: String?
    var didAnswerCorrectly: Bool?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Kickers-Regular", size: 25))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.2)
            .foregroundStyle(getOptionFontColor(answer))
            .frame(maxWidth: .infinity)
            .padding(10)
            .background {
                Capsule()
                    .fill(getOptionBackgroundColor(answer))
            }
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .layoutPriority(1)
    }
    
    func getOptionBackgroundColor(_ answer: String) -> Color {
        guard let selectedOption, let isCorrect = didAnswerCorrectly else {
            return .quizOffWhite
        }
        
        if answer == selectedOption {
            return isCorrect ? .quizGreen : .quizOffBlack
        }
        
        return .quizOffWhite
    }
    
    func getOptionFontColor(_ answer: String) -> Color {
        return answer == selectedOption && didAnswerCorrectly != nil ? .white : .quizOffBlack
    }
}
