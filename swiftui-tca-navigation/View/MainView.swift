import SwiftUI
import SwiftData
import ComposableArchitecture

struct MainView: View {
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

#Preview {
  MainView(store: Store(initialState: ContactsFeature.State()) {
    ContactsFeature()
  })
}
