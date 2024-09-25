//
//  ContentView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Group {
                    Text("Quem está por aqui?")
                        .font(Font.custom("Kickers-Regular", size: 55))
                    Text("Já faz parte da turma ou está criando uma perfil agora?")
                }
                .padding(.horizontal, 60)
                
                TabView {
                    ProfileSelection()
                    ProfileSelection()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                
                Button("Começar Quiz") {}
                    .buttonStyle(LargeButtonStyle())
            }
            .foregroundStyle(.quizOffBlack)
            .multilineTextAlignment(.center)
            .padding(.vertical)
            .frame(maxHeight: .infinity)
            .background(
                Color.quizOffWhite
                    .ignoresSafeArea(edges: .all)
            )
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
