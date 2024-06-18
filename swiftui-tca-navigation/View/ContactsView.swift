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
    
    //Navigation
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      List {
        ForEach(store.contacts) { contact in
          //Navigation
          NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
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
    } destination: { store in //Navigation Destination
      ContactDetailView(store: store)
    }
    //present AddContactView (child)
    .sheet(
      //item: $store.scope(state: \.addContact, action: \.addContact)
      item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
    ) { addContactStore in
      NavigationStack {
        AddContactView(store: addContactStore)
      }
    }
    // present AlertView
    //.alert($store.scope(state: \.alert, action: \.alert))
    .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
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
