//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by students on 17/12/25.
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Listt.self)
        }
    }
}
