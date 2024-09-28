//
//  HomeViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var displayingAlert = false
    
    var didNotLoadYet: Bool {
        NetworkService.shared.questions.isEmpty
    }
    var hasError: Bool {
        return NetworkService.shared.anErrorOccurred
    }
    
    var cantStartQuiz: Bool {
        didNotLoadYet && !hasError
    }
    
    func tryLoadingAgain() {
        NetworkService.shared.fetchQuestions()
    }
}
