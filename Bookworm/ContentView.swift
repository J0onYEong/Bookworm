//
//  ContentView.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/12.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @Environment(\.managedObjectContext) var moc
    
    @State var showingAddBookView = false
    
    var body: some View {
        NavigationView {
            Text("\(books.count)")
                .toolbar {
                    Button {
                        showingAddBookView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddBookView) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}
