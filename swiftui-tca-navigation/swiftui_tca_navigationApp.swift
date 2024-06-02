//
//  swiftui_tca_navigationApp.swift
//  swiftui-tca-navigation
//
//  Created by Han-Saem Park on 2024-06-02.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct swiftui_tca_navigationApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      ContactsView(store: Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
      })
    }
    .modelContainer(sharedModelContainer)
  }
}
