import SwiftUI
import SwiftData
import ComposableArchitecture

struct ContactsView: View {
  //MARK: - SwiftData
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  
  //MARK: - Store
  let store: StoreOf<ContactsFeature>
  
  //MARK: - BODY
  var body: some View {
    NavigationStack {
      List {
        ForEach(store.contacts) { contact in
          Text(contact.name)
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
