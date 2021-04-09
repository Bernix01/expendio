//
//  Persistence.swift
//  Shared
//
//  Created by Guillermo Bernal Moreira on 3/4/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        clearAll(coordinator: result.container.persistentStoreCoordinator, viewContext: viewContext)
        
        let fooAccount = EAccount(context: viewContext)
        fooAccount.name = "ExpendioBank"
        fooAccount.initialBalance = 20.0
        for _ in 0..<10 {
            let newItem = ETransaction(context: viewContext)
            newItem.timestamp = Date()
            newItem.amount = Double.random(in: -20.0...20.0)
            let descriptionLbl = EItemLabel(context: viewContext)
            descriptionLbl.name = "description"
            descriptionLbl.value = "Transaction"
            newItem.labels = [descriptionLbl]
            newItem.account = fooAccount
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Expendio")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}


func  clearAll(coordinator: NSPersistentStoreCoordinator ,viewContext: NSManagedObjectContext) -> Void {
    
    
    do {
        let fetchRequest3: NSFetchRequest<NSFetchRequestResult> = ETransaction.fetchRequest()
        let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
        print("aaa")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EItemLabel.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        print("aaa")
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = EAccount.fetchRequest()
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        print("aaa")
        try coordinator.execute(deleteRequest, with: viewContext)
        try coordinator.execute(deleteRequest3, with: viewContext)
        try coordinator.execute(deleteRequest2, with: viewContext)
        try viewContext.save()
    } catch let error as NSError {
        print(error)
    }
}
