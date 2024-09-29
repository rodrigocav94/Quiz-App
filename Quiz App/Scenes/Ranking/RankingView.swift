//
//  RankingView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI
import SwiftData

struct RankingView: View {
    @Query (sort: [
        SortDescriptor (\Profile.maxScore, order: .reverse),
        SortDescriptor (\Profile.name)
    ]) var profiles: [Profile]
    
    var body: some View {
        VStack {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            ScrollView(.vertical) {
                LazyVStack {
                    Header
                    if profiles.isEmpty {
                        EmptyRanking
                    } else {
                        RankingCells
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .mask(GradientMask)
        }
        .foregroundStyle(.quizOffWhite)
        .background(.quizGreen)
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Header
extension RankingView {
    var Header: some View {
        Group {
            Image("ranking-background")
                .resizable()
                .scaledToFit()
                .background(
                    SpinningLight()
                )
            Text("Hall da Fama")
                .font(Font.custom("Kickers-Regular", size: 55))
            Text("Descubra quem brilhou no quiz!")
                .padding(.bottom, 20)
        }
    }
}

// MARK: - Empty Ranking
extension RankingView {
    var EmptyRanking: some View {
        Text("Cri cri cri... Ainda não temos ninguém no Hall da Fama. Crie um perfil e responda algumas perguntas para ver seu nome por aqui!")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

// MARK: - Gradient Mask
extension RankingView {
    var GradientMask: some View {
        LinearGradient(
            stops: [
                .init(color: .clear, location: 0),
                .init(color: .black, location: 0.04),
                .init(color: .black, location: 0.96),
                .init(color: .clear, location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Ranking Cells
extension RankingView {
    var RankingCells: some View {
        ForEach(Array(profiles.enumerated()), id: \.element.id) { (index, profile) in
            HStack(spacing: 20) {
                Image("pfp\(profile.icon)")
                    .resizable()
                    .scaledToFit()
                Text("\(index + 1). \(profile.name)")
                    .font(Font.custom("Kickers-Regular", size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                
                Text("\(profile.maxScore) acertos")
                    .font(Font.custom("Kickers-Regular", size: 25))
            }
            .padding(.trailing)
            .frame(height: 50)
            .background(Capsule().stroke(.quizOffWhite, lineWidth: 2))
        }
    }
}
#Preview {
    RankingView()
}
