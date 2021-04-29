//
//  Sidebar.swift
//  Expendio (iOS)
//
//  Created by Guillermo Bernal Moreira on 4/4/21.
//

import Foundation
import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            SidebarItem(destination: DashboardView(), label: "Dashboard", icon: "1.circle")
            SidebarItem(destination: TransactionsView(), label: "Transactions", icon: "2.circle")
            SidebarItem(destination: AccountsView(), label: "Accounts", icon: "3.circle")
            SidebarItem(destination: DetailSplitView(number: 4), label: "Budgets", icon: "4.circle")
        }
        .listStyle(SidebarListStyle())
    }
}


struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
