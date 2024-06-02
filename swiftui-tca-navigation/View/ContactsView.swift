import SwiftUI
import SwiftData
import ComposableArchitecture

struct ContactsView: View {
  //MARK: - SwiftData
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  
  //MARK: - Store
  @Bindable var store: StoreOf<ContactsFeature>
  
  //MARK: - BODY
  var body: some View {
    
    NavigationStack {
      List {
        ForEach(store.contacts) { contact in
          HStack {
            Text(contact.name)
            Spacer()
            Button {
              store.send(.deleteButtonTapped(id: contact.id))
            } label: {
              Image(systemName: "trash")
                .foregroundColor(.red)
            }
          }
        }
      }
      .navigationTitle("Contacts")
      .toolbar {
        ToolbarItem {
          Button {
            store.send(.addButtonTapped)
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    //present AddContactView (child)
    .sheet(
      item: $store.scope(state: \.addContact, action: \.addContact)
    ) { addContactStore in
      NavigationStack {
        AddContactView(store: addContactStore)
      }
    }
    // present AlertView
    .alert($store.scope(state: \.alert, action: \.alert))
    
  }
}

//MARK: - PREVIEW
#Preview {
  ContactsView(store: Store(initialState: ContactsFeature.State(
    contacts: [
      Contact(id: UUID(), name: "Blob"),
      Contact(id: UUID(), name: "Blob Jr"),
      Contact(id: UUID(), name: "Blob Sr"),
    ]
  )) {
    ContactsFeature()
  })
}
