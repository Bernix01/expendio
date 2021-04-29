//
//  TransactionDetailView.swift
//  Expendio
//
//  Created by Guillermo Bernal Moreira on 4/15/21.
//

import Foundation
import SwiftUI
import CoreData

struct TransactionDetailView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @ObservedObject var transaction : ETransaction
    
    @State
    var isEditEnabled = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text("\(transaction.amount < 0 ? "-" : "")$\(abs(transaction.amount), specifier: "%.2f")").font(.largeTitle).bold()
                    Text(transaction.subject).font(.title3).bold()
                }
                Spacer()
                Button(action: {
                    isEditEnabled.toggle()
                }, label: {
                    Text("Editar")
                })
            }
            HStack {
                ForEach(transaction.labelsArray, id: \.self) { label in
                    VStack {
                        Text(label.name ?? "")
                        Text(label.value ?? "")
                    }
                }
            }
            Spacer()
            Button(action: {
                viewContext.delete(transaction)
                try? viewContext.save()
            }, label: {
                Text("Eliminar")
            })
        }
        .padding(.all)
        .sheet(isPresented: $isEditEnabled) {
            TransactionEditView(transaction: transaction, isVisible: $isEditEnabled)
        }
    }
}


struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let t: NSFetchRequest<ETransaction> = ETransaction.fetchRequest()
        let r = try? PersistenceController.preview.container.viewContext.fetch(t)
        return TransactionDetailView(transaction: r!.first!).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
