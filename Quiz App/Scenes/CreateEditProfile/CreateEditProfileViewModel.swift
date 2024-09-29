//
//  CreateEditProfileViewModel.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import Foundation
import SwiftData
import MSwiftUINavigator

class CreateEditProfileViewModel: ObservableObject {
    @Published var displayingAlert = false
    @Published var name = ""
    @Published var pfpIndex = Int.random(in: 1...17)
    
    func updateInfo(profile: Profile?) {
        if let profile {
            name = profile.name
            pfpIndex = profile.icon
        }
    }
    
    func onArrowButton(_ goesToTheLeft: Bool) {
        if goesToTheLeft {
            if pfpIndex > 1 {
                pfpIndex -= 1
            }
        } else {
            if pfpIndex < 17 {
                pfpIndex += 1
            }
        }
    }
    
    func onSave(context: ModelContext, profile: Profile? ) {
        if name.isEmpty {
            displayingAlert = true
            return
        }
        
        if let profile {
            profile.icon = pfpIndex
            profile.name = name
            try? context.save()
        } else {
            let newProfile = Profile(name: name, icon: pfpIndex, maxScore: 0)
            context.insert(newProfile)
        }
        
        NavigationManager.shared.popView()
    }
    
    func onDelete(context: ModelContext, profile: Profile, homeVM: HomeViewModel) {
        context.delete(profile)
        homeVM.selectedProfile = nil
        NavigationManager.shared.popView()
    }
}
