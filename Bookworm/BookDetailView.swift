//
//  BookDetailView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/13.
//

import SwiftUI
import Foundation

struct BookDetailView: View {
    var book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    
    var dateText: Text {
        if let date = book.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            return Text(dateString)
        }
        return Text("no data")
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding([.bottom, .trailing], 10)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(book.author ?? "Unknown author")
                        .font(.title)
                        .padding(.bottom, 10)
                    Section {
                        RatingView(rating: .constant(Int(book.rating)))
                            .padding(.bottom, 10)
                        Text(book.review ?? "Empty comment")
                            .font(.caption)
                    }
                    dateText
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .opacity(0.7)
                }
                .padding(.leading)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Delete") {
                        showingAlert = true
                    }
                }
            }
        }
        .navigationTitle(book.title ?? "Unknown title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingAlert) {
            Button("cancel"){}
            Button("confirm"){ deleteBook() }
        } message: {
            Text("Are you sure?")
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}


