//
//  Dashboard.swift
//  Expendio
//
//  Created by Guillermo Bernal Moreira on 4/20/21.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        Text("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
