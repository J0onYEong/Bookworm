//
//  BookRow.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/16.
//

import SwiftUI
import CoreData

struct BookRow: View {
    var book: Book
    
    var body: some View {
        HStack {
            ZStack {
                EmojiRatingView(rating: Int(book.rating))
            }
            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown Title")
                    .font(.headline)
                Text(book.author ?? "Unknown Author")
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 50)
    }
}

struct BookRow_Previews: PreviewProvider {
    static var moc = DataController().container.viewContext
    static var previews: some View {
        BookRow(book: Book(context: moc))
    }
}
