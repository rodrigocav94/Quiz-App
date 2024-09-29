//
//  ProfileSelection.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct ProfileSelection: View {
    var profile: Profile?
    
    var body: some View {
        NavigationLink(destination: CreateEditProfileView(profile: profile)) {
            VStack {
                Image("pfp\(profile?.icon ?? 0)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220)
                Text(profile?.name ?? "Criar")
                    .font(Font.custom("Kickers-Regular", size: 40))
                    .lineLimit(2)
            }
            .padding(.horizontal, 60)
            .multilineTextAlignment(.center)
            .foregroundStyle(.quizOffBlack)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ProfileSelection()
    }
}
