//
//  Rato_de_BibliotecaApp.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 12/06/21.
//

import SwiftUI

@main
struct Rato_de_BibliotecaApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
