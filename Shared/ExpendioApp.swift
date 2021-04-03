//
//  ExpendioApp.swift
//  Shared
//
//  Created by Guillermo Bernal Moreira on 3/4/21.
//

import SwiftUI

@main
struct ExpendioApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
