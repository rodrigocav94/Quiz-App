//
//  HomeViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var selectedProfile: Profile? = UserDefaultsManager.lastKnownProfile {
        didSet {
            UserDefaultsManager.lastKnownProfile = selectedProfile
        }
    }
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
    
    func updateProfileSelection(withQuery profiles: [Profile]) {
        selectedProfile = profiles.first(where: {
            $0.id == UserDefaultsManager.lastKnownProfile?.id
        })
    }
    
    func getProfileIndex(query profiles: [Profile]) -> Int {
        if let selectedProfile {
            return (profiles.firstIndex(of: selectedProfile) ?? 0) + 1
        }
        
        return profiles.count + 1
    }
}
