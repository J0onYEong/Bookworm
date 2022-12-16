//
//  AddBookView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/13.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    //input state
    @State var title = ""
    @State var author = ""
    @State var genre = "Fantasy"
    @State var rating = 0
    @State var review = ""
    
    var inputValidation: Bool {
        return !title.trimmingCharacters(in: .whitespaces).isEmpty && !author.trimmingCharacters(in: .whitespaces).isEmpty && !review.trimmingCharacters(in: .whitespaces).isEmpty
    }

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("title", text: $title)
                    TextField("author", text: $author)
                    Picker("genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genreStr in
                            Text(genreStr)
                        }
                    }
                } header: {
                    Text("Book information")
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                
                Section {
                    RatingView(label: "rating", rating: $rating)
                    TextField("comment", text: $review)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("write a review")
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    Button("close") { dismiss() }
                    Rectangle().frame(width: 1, height: 20)
                        .foregroundColor(.secondary)
                    Button("Add") {
                        let book = Book(context: moc)
                        book.title = title
                        book.author = author
                        book.genre = genre
                        book.rating = Int16(rating)
                        book.review = review
                        book.date = Date.now
                        
                        try? moc.save()
                        
                        // dismissing when add process is finshed
                        dismiss()
                    }
                    .disabled(!inputValidation)
                }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
