//
//  ETransaction+CoreDataClass.swift
//  Expendio
//
//  Created by Guillermo Bernal Moreira on 4/4/21.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(ETransaction)
public class ETransaction: NSManagedObject {

    
}

extension ETransaction {
    
    var  labelsArray: [EItemLabel] {
      let set = labels as? Set<EItemLabel> ?? []
      return set.sorted {
        $0.name ?? "a" < $1.name ?? "b"
      }.filter{ $0.name != "description" }
    }
    
    
    var subject: String {
        let set = labels as? Set<EItemLabel>  ?? []
        if let lbl = set.first(where: {$0.name == "description" }) {
            return lbl.value ?? ""
        }
        return ""
    }
}
