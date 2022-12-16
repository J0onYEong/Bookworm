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
                GeometryReader { geo in
                    LinearGradient(colors: [.gray.opacity(0), .gray, .gray.opacity(0)], startPoint: .top, endPoint: .bottom)
                        .frame(width: 1)
                        .padding([.top, .bottom], 5)
                        .position(x: geo.size.width/2, y: geo.size.height/2)
                }
                .frame(width: 1)            }
            //
            ForEach(1..<6) { number in
                image(number: number)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.175)) {
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
        NavigationView {
            Form {
                Section {
                    RatingView(label: "test label", rating: .constant(4))
                        .frame(height: 100)
                }
            }
        }
    }
}
