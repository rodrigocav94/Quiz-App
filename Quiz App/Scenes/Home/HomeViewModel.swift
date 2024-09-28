//
//  HomeViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var questions = [Question]()
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchQuestions() {
        // Reset any previous error and show loading state
        isLoading = true
        errorMessage = nil
        
        NetworkService.fetchTenQuestions()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
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
}
