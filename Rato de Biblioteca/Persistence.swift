//
//  Persistence.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 12/06/21.
//

import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // Create 10 example programming languages.
        for numero in 0..<10 {
            let livro = Livro(context: controller.container.viewContext)
            livro.id = UUID()
            livro.titulo = "Titulo \(numero)"
            livro.autor = "Autor \(numero)"
            livro.nota = Int16(5)
            livro.genero = "Romance"
            livro.analise = "Péssimo"
        }

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "Rato_de_Biblioteca")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
