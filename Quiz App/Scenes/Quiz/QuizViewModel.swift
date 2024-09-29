//
//  QuizViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine
import MSwiftUINavigator

class QuizViewModel: ObservableObject {
    @Published var score = 0
    @Published var selectedOption: String? = nil
    @Published var didAnswerCorrectly: Bool? = nil
    var questions = NetworkService.shared.questions.isEmpty ? [.mock] : NetworkService.shared.questions
    @Published var questionIndex = 0
    var currentQuestion: Question {
        questions[questionIndex]
    }
    @Published var displayingAlert = false
    private var cancellables = Set<AnyCancellable>()
    
    func answer(_ answer: String) {
        selectedOption = answer
        NetworkService.submitAnswer(questionId: currentQuestion.id, answer: answer)
            .receive(on: DispatchQueue.main) // Ensure response is received on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("Answer submitted successfully.")
                case .failure(let error):
                    print("Error submitting answer: \(error.localizedDescription)")
                    displayingAlert = true
                }
            }, receiveValue: { [weak self] response in
                let isCorrectAnswer = response.result
                self?.didAnswerCorrectly = isCorrectAnswer
                if isCorrectAnswer {
                    self?.score += 1
                }
                self?.displayNextQuestion()
            })
            .store(in: &cancellables) // Store cancellables to avoid memory leaks
    }
    
    func displayNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            let nextQuestion = questionIndex + 1
            if questions.indices.contains(nextQuestion) {
                questionIndex = nextQuestion
                selectedOption = nil
                didAnswerCorrectly = nil
            } else {
                NavigationManager.shared.pushView {
                    FinishView()
                }
            }
        }
    }
}
