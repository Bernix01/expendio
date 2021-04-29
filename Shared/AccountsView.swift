//
//  AccountsView.swift
//  Expendio
//
//  Created by Guillermo Bernal Moreira on 4/20/21.
//

import Foundation
import SwiftUI

struct AccountsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EAccount.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<EAccount>
    
    var body: some View{
        List {
            ForEach(items, id: \.self) { item in
                Text("\(item.name ?? "")")
            }
        }.toolbar {
            ToolbarItem(placement: .automatic, content: {
                #if os(iOS)
                EditButton()
                #endif
            })
            
            ToolbarItem(placement: .automatic, content: {
                Button("Add", action: {})
            })
            #if os(iOS)
            ToolbarItem(placement: .bottomBar, content: {
                Button("Add", action: {})
            })
            #endif
        }
    }
}


struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
