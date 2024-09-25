//
//  ProfileSelection.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct ProfileSelection: View {
    var name: String?
    var pfpIndex: Int?
    
    var body: some View {
        NavigationLink(destination: CreateEditProfileView()) {
            VStack {
                Image("pfp\(pfpIndex ?? 0)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220)
                Text(name ?? "Criar")
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
        ProfileSelection(
            name: "Rodrigo",
            pfpIndex: 2
        )
    }
}
