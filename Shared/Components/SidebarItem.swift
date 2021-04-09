//
//  SidebarItem.swift
//  Expendio (iOS)
//
//  Created by Guillermo Bernal Moreira on 4/4/21.
//

import Foundation
import SwiftUI

struct SidebarItem<Destination>: View where Destination: View {
    private let destination: Destination
    private let label: String
    private let icon: String
    
    init(destination: Destination, label: String, icon: String) {
        self.destination = destination
        self.label = label
        self.icon = icon
    }
    var body: some View {
        NavigationLink(destination: destination) {
            Label(label, systemImage: icon)
        }
    }
}
