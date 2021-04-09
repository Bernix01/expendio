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
            SidebarItem(destination: DetailSplitView(number: 1), label: "Dashboard", icon: "1.circle")
            SidebarItem(destination: TransactionsView(), label: "Transactions", icon: "2.circle")
            SidebarItem(destination: DetailSplitView(number: 3), label: "Accounts", icon: "3.circle")
            SidebarItem(destination: DetailSplitView(number: 4), label: "Budgets", icon: "4.circle")
        }
        .listStyle(SidebarListStyle())
    }
}

