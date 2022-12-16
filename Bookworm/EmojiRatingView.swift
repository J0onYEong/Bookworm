//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/13.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    var starImage: some View {
        Image(systemName: "star.fill")
            .foregroundStyle(.linearGradient(colors: [.yellow, .orange, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    let angleAdjust = [0.0, 0.0, Double.pi/6, 0.0, Double.pi/10*3]
    let radiusAdjust = [0,0.4,0.5,0.5,0.5]
    let scaleAdust = [1.5,1.5,1.5,1.5,1.5]
    
    var body: some View {
        GeometryReader { geo in
            let radius = geo.size.height/2
            let interval = Double.pi*2 / Double(rating)
            let angleArr = stride(from: 0.0, to: Double.pi*2, by: interval).map {$0}
            ZStack {
                ForEach(angleArr, id: \.self) { angle in
                    let posX = geo.size.width/2 + cos(angle+angleAdjust[rating-1])*(radius*radiusAdjust[rating-1])
                    let posY = geo.size.width/2 + sin(angle+angleAdjust[rating-1])*(radius*radiusAdjust[rating-1])
                    starImage
                        .scaleEffect(geo.size.width/100 * scaleAdust[rating-1])
                        .position(x:posX, y:posY)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        List(1..<6) {
            EmojiRatingView(rating: $0)
        }
    }
}
