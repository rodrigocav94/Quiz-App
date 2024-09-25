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
        NavigationLink(destination: EmptyView()) {
            VStack {
                Image("pfp\(pfpIndex ?? 0)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220)
                Text(name ?? "Criar")
                    .font(Font.custom("Kickers-Regular", size: 47))
            }
            .padding(.horizontal, 60)
            .multilineTextAlignment(.center)
            .foregroundStyle(.quizOffBlack)
        }
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
