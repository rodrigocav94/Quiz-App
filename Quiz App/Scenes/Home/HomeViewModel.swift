//
//  HomeViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    var isLoading: Bool {
        NetworkService.shared.questions.isEmpty
    }
    var hasError: String? {
        return NetworkService.shared.errorMessage
    }
}
