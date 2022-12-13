//
//  DataController.swift
//  Bookworm
//
//  Created by 최준영 on 2022/12/12.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    var container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
