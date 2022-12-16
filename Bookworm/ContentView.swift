//
//  ContentView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/12.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book>
    @Environment(\.managedObjectContext) var moc
    
    @State var showingAddBookView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        BookRow(book: book)
                    }
                }
                .onDelete(perform: removeBooks)
            }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            showingAddBookView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddBookView) {
                    AddBookView()
                }
        }
    }
    
    func removeBooks(at offsets: IndexSet) {
        for offset in offsets {
            let target = books[offset]
            moc.delete(target)
        }
        try? moc.save()
    }
}
