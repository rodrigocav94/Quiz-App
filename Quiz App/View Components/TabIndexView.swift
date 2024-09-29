//
//  TabIndexView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 29/09/24.
//

import SwiftUI
struct TabViewIndex: View {
    var currentIndex: Int
    var total: Int
    
    // Optional styling properties
    var circleHeight: CGFloat = 8
    var spacing: CGFloat = 10
    var selectedColor = Color.quizGreen
    var unselectedColor = Color.quizGreen.opacity(0.5)
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(1...total, id: \.self) {
                Circle()
                    .frame(width: circleHeight, height: circleHeight)
                    .foregroundColor($0 == currentIndex ? selectedColor : unselectedColor)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            .thinMaterial
        )
        .clipShape(Capsule())
    }
}

#Preview {
    TabViewIndex(currentIndex: 2, total: 10)
}
