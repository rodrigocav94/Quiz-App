//
//  QuizView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 28/09/24.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                BackButton()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        HStack(spacing: 3) {
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.quizGreen)
                            Text("5:10")
                        }
                        .frame(maxHeight: .infinity)
                        .bold()
                        .padding(.horizontal, 20)
                        .overlay(Capsule().stroke(.quizOffWhite, lineWidth: 2))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
            }
            
            HStack(spacing: 20) {
                HStack(spacing: 3) {
                    Image(systemName: "checkmark.seal.fill")
                    Text("3")
                }
                .bold()
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
                .background {
                    Capsule()
                        .fill(.quizGreen)
                }
                .foregroundStyle(.white)
                
                HStack(spacing: 3) {
                    ForEach(1...10, id: \.self) {step in
                        Capsule()
                            .frame(height: 4)
                            .foregroundStyle(step > 3 ? .quizOffWhite.opacity(0.5) : .quizGreen)
                    }
                }
            }
            
            VStack(spacing: 40) {
                Text(Question.mock.statement)
                    .font(Font.custom("Kickers-Regular", size: 50))
                    .minimumScaleFactor(0.1)
                    .layoutPriority(1)
                
                VStack(spacing: 10) {
                    ForEach(Array(Question.mock.options.enumerated()), id: \.element) { (index, element) in
                        Text(element)
                            .font(Font.custom("Kickers-Regular", size: 25))
                            .foregroundStyle(index == 0 ? .quizOffWhite : .quizOffBlack)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background {
                                Capsule()
                                    .fill(index == 0 ? .quizGreen : .quizOffWhite)
                            }
                    }
                }
            }
            .padding(.bottom)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .background(alignment: .topTrailing) {
                Image("quiz-background")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                    .offset(x: 40)
            }
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.quizPink)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    QuizView()
}
