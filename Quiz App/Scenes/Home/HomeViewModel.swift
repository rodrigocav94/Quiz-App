//
//  HomeViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var selectedProfile: Profile? = nil
    @Published var displayingAlert = false
    
    var didNotLoadYet: Bool {
        NetworkService.shared.questions.isEmpty
    }
    var hasError: Bool {
        return NetworkService.shared.anErrorOccurred
    }
    
    var cantStartQuiz: Bool {
        didNotLoadYet && !hasError || selectedProfile == nil
    }
    
    func tryLoadingAgain() {
        NetworkService.shared.fetchQuestions()
    }
}
