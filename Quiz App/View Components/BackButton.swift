//
//  BackButton.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title.weight(.bold))
                .padding()
                .background(.white)
                .clipShape(Circle())
                .foregroundStyle(.quizOffBlack)
        }
    }
}

#Preview {
    BackButton()
}
