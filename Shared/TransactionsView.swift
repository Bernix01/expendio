//
//  TransactionsView.swift
//  Expendio
//
//  Created by Guillermo Bernal Moreira on 4/4/21.
//

import Foundation
import SwiftUI

struct TransactionsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ETransaction.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ETransaction>
    @State var showModal: Bool = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(destination: TransactionDetailView(transaction: item)) {
                        VStack(alignment: .leading){
                            Text("\(item.amount < 0 ? "-" : " ")$\(abs(item.amount), specifier: "%.2f")")
                                .font(.headline)
                            Text("\(item.subject)")
                                .font(.subheadline)
                            Text("\(item.timestamp ?? Date(), formatter: itemFormatter)")
                                .font(.caption)
                        }.padding(.bottom)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Transactions")
            .overlay(ModalView(showModal: $showModal))
            .toolbar {
                ToolbarItem(placement: .automatic, content: {
                    #if os(iOS)
                    EditButton()
                    #endif
                })
                
                ToolbarItem(placement: .automatic, content: {
                    Button("Add", action: addItem)
                })
                #if os(iOS)
                ToolbarItem(placement: .bottomBar, content: {
                    Button("Add", action: addItem)
                })
                #endif
            }
        
        }
    }
    
    private func getDescription(item: ETransaction) -> String{
        guard let labels = item.labels as? Set<EItemLabel> else {
            return ""
        }
        return labels.first { $0.name == "description" }?.value ?? ""
    }
    
    private func addItem() {
        clearAll(coordinator: viewContext.persistentStoreCoordinator!, viewContext: viewContext)
        withAnimation {
            let newItem = ETransaction(context: viewContext)
            newItem.timestamp = Date()
            newItem.amount = Double.random(in: -20.00...20.00)
            newItem.account = try? viewContext.fetch(EAccount.fetchRequest()).first
            let lbl = EItemLabel(context: viewContext)
            lbl.name = "description"
            lbl.value = "Test"
            newItem.labels = [lbl]
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                viewContext.refreshAllObjects()
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ModalView: View { // draws a semi-transparent rectangle that contains the modal
    @Binding var showModal: Bool
    
    var body: some View {
        Group {
            if showModal {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.white)
                                .frame(width: min(geometry.size.width - 100, 300), height: min(geometry.size.height - 100, 200))
                                .overlay(ModalContentView(showModal: self.$showModal))
                        }
                    )
            }
        }
    }
}


struct ModalContentView: View { // the real modal content
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Modal Content")
            
            Button(action: {
                self.showModal.toggle()
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                    Text("Close Modal")
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView().frame(width: 150.0).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
