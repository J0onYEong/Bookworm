//
//  BookwormApp.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/12.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
