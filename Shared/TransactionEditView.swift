//
//  TransactionEditView.swift
//  Gasto
//
//  Created by Guillermo Bernal Moreira on 4/28/21.
//

import Foundation
import SwiftUI
import CoreData

public class DoubleFormatter: Formatter {
    
    override public func string(for obj: Any?) -> String? {
        var retVal: String?
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let dbl = obj as? Double {
            retVal = formatter.string(from: NSNumber(value: dbl))
        } else {
            retVal = nil
        }
        
        return retVal
    }
    
    override public func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        var retVal = true
        
        if let dbl = Double(string), let objok = obj {
            objok.pointee = dbl as AnyObject?
            retVal = true
        } else {
            retVal = false
        }
        
        return retVal
        
    }
}
struct TransactionEditView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @ObservedObject var transaction : ETransaction
    @Binding var isVisible: Bool
    @State var error = ""
    
    var body: some View {
        VStack{
            HStack{
                Button("cancel", action: {
                    self.isVisible.toggle()
                })
                Spacer()
                Button("done", action: {
                    do {
                        try viewContext.save()
                        self.isVisible.toggle()
                    }catch {
                        let nsError = error as NSError
                        self.error = "Unresolved error \(nsError), \(nsError.userInfo)"
                    }
                })
            }
            if !error.isEmpty {
                Text(error)
            }
            TextField("amount", value: $transaction.amount, formatter: DoubleFormatter())
            Spacer()
        }
        .padding(.all)
    }
}


struct TransactionEditView_Previews: PreviewProvider {
    static var previews: some View {
        let t: NSFetchRequest<ETransaction> = ETransaction
            .fetchRequest()
        let r = try? PersistenceController
            .preview
            .container
            .viewContext
            .fetch(t)
        return TransactionEditView(
            transaction: r!.first!,
            isVisible: Binding.constant(false)
        )
        .environment(\.managedObjectContext,
                     PersistenceController.preview.container.viewContext
        )
    }
}

