//
//  ContentView.swift
//  Shared
//
//  Created by Guillermo Bernal Moreira on 3/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
                    Sidebar()
                   Text("Main")
                   Text("Detail")
               }
    }

}


// Working as expected in a split view context
struct DetailSplitView: View {
    let number: Int
    var body: some View {
        VStack(spacing: 20) {
            Text("Main view for: \(number)")
            NavigationLink(destination: Text("Detail view for: \(number)")) {
                Text("Press here for detail")
            }
        }
    }
}

// Ideally want this to take up the whole screen (not just one side of a split view)
struct DetailNoSplitView: View {
    let number: Int
    var body: some View {
        Text("Detail view for \(number)")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
