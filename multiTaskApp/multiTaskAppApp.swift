//
//  multiTaskAppApp.swift
//  multiTaskApp
//
//  Created by asmaa gamal  on 15/12/2023.
//

import SwiftUI

@main
struct multiTaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeSwiftUIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
