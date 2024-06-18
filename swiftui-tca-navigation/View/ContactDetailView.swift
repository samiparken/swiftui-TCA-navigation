//
//  ContactDetailView.swift
//  swiftui-tca-navigation
//
//  Created by Han-Saem Park on 2024-06-18.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
  @Bindable var store: StoreOf<ContactDetailFeature>
  
  var body: some View {
    Form {
      Button("Delete") {
        store.send(.deleteButtonTapped)
      }
    }
    .navigationTitle(Text(store.contact.name))
    .alert($store.scope(state: \.alert, action: \.alert))
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
