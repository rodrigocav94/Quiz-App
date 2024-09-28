//
//  NetworkService.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class NetworkService: ObservableObject {
    // MARK: - Shared instance to cache results.
    @Published var questions = [Question]()
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchQuestions() {
        // Reset any previous error and show loading state
        errorMessage = nil
        
        NetworkService.fetchTenQuestions()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }                
                switch completion {
                case .finished:
                    print("Finished fetching 10 questions.")
                case .failure(let error):
                    self.errorMessage = "Error fetching questions: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] questionResponse in
                self?.questions = questionResponse
            })
            .store(in: &cancellables)  // Store the cancellable to avoid memory leaks
    }
    
    // MARK: - Static parameters and Methods
    static let shared = NetworkService()
    
    static private let baseURL = "https://quiz-api-bwi5hjqyaq-uc.a.run.app"
    
    // Function to fetch 10 unique questions
    static func fetchTenQuestions() -> AnyPublisher<[Question], Error> {
        // Start recursion with an empty result set
        return fetchQuestionsRecursively([])
    }
    
    // Function to be repeated by adding results
    static func fetchQuestionsRecursively(_ results: [Question]) -> AnyPublisher<[Question], Error> {
        // Base case: if we've collected 10 unique questions, return them
        if results.count >= 10 {
            return Just(results)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        // Otherwise, fetch another question
        return fetchQuestion()
            .flatMap { question -> AnyPublisher<[Question], Error> in
                var updatedResults = results
                
                // Check if the question's ID is already in the result set
                if !updatedResults.contains(where: { $0.id == question.id }) {
                    updatedResults.append(question)  // Add only if the ID is unique
                }
                
                // Recurse to fetch more questions until we have 10 unique ones
                return fetchQuestionsRecursively(updatedResults)
            }
            .eraseToAnyPublisher()
    }
    
    // Function to fetch a single question
    static func fetchQuestion() -> AnyPublisher<Question, Error> {
        let url = URL(string: "\(baseURL)/question")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Question.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    
    static func submitAnswer(questionId: String, answer: String) -> AnyPublisher<AnswerResponse, Error> {
        let url = URL(string: "\(baseURL)/answer?questionId=\(questionId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let answerBody = Answer(answer: answer)
        request.httpBody = try? JSONEncoder().encode(answerBody)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AnswerResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private init() {}
}
