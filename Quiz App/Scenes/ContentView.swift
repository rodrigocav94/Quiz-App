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
                Text("Ver ranking")
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .overlay(Capsule().stroke(.quizGreen, lineWidth: 1))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                Group {
                    Text("Quem está por aqui?")
                        .font(Font.custom("Kickers-Regular", size: 55))
                    Text("Já faz parte da turma ou está criando uma perfil agora?")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 60)
                
                TabView {
                    ProfileSelection(name: "Corwin", pfpIndex: 2)
                    ProfileSelection()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                
                NavigationLink {
                    QuizView()
                } label: {
                    Text("Começar Quiz")
                }
                .buttonStyle(LargeButtonStyle())
                .padding(.horizontal, 60)
                .padding(.bottom)
                
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
