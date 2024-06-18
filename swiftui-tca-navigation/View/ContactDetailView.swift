//
//  ContactDetailView.swift
//  swiftui-tca-navigation
//
//  Created by Han-Saem Park on 2024-06-18.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
  let store: StoreOf<ContactDetailFeature>
  
  var body: some View {
    Form {
      
      
    }
    .navigationTitle(Text(store.contact.name))
    
  }
}

#Preview {
  NavigationStack {
    ContactDetailView(
      store: Store(
        initialState: ContactDetailFeature.State(
          contact: Contact(id: UUID(), name: "Blob")
        )
      ) {
        ContactDetailFeature()
      }
    )
  }
}
