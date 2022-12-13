//
//  RatingView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/13.
//

import SwiftUI

struct RatingView: View {
    var label = ""
    @Binding var rating: Int
    
    func image(number: Int) -> some View {
        let onImage = Image(systemName: "star.fill")
            .foregroundColor(.yellow)
        let offImage = Image(systemName: "star")
            .foregroundColor(.gray)
        
        if rating < number {
            return offImage
        }
        return onImage
    }
    
    var body: some View {
        HStack {
            // label
            if !label.isEmpty {
                Text(label)
                Rectangle()
                    .frame(width: 1, height: .infinity)
                    .foregroundColor(.gray)
                    .padding([.top, .bottom])
            }
            //
            ForEach(1..<6) { number in
                image(number: number)
                    .onTapGesture {
                        withAnimation {
                            if rating == number {
                                rating = 0
                                return
                            }
                            rating = number
                        }
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(label: "test label", rating: .constant(4))
    }
}
