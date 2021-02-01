//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Vahagn Martirosyan on 2021-01-31.
//

import SwiftUI

@main
struct BookWormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
