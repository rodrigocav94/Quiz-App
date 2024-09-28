//
//  QuizViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import MSwiftUINavigator

class QuizViewModel: ObservableObject {
    var questions = NetworkService.shared.questions.isEmpty ? [.mock] : NetworkService.shared.questions
    @Published var questionIndex = 0
    var currentQuestion: Question {
        questions[questionIndex]
    }
    
    func answer(_ answer: String) {
        let nextQuestion = questionIndex + 1
        if questions.indices.contains(nextQuestion) {
            questionIndex = nextQuestion
        } else {
            NavigationManager.shared.pushView {
                FinishView()
            }
        }
    }
}
