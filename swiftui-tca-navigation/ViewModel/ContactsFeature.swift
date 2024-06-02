import Foundation
import ComposableArchitecture

@Reducer
struct ContactsFeature {
  //MARK: - State
  @ObservableState
  struct State: Equatable {
    @Presents var addContact: AddContactFeature.State?
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  //MARK: - Action
  enum Action {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>)
  }
  //MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .addButtonTapped:
        state.addContact = AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        )
        return .none
                
      case .addContact(.presented(.cancelButtonTapped)):
        state.addContact = nil
        return .none
        
      case .addContact(.presented(.saveButtonTapped)):
        guard let contact = state.addContact?.contact
        else { return .none }
        state.contacts.append(contact)
        state.addContact = nil
        return .none
        
      case .addContact:
        return .none
        
      }
    }
    .ifLet(\.$addContact, action: \.addContact) {
      AddContactFeature()
    }
  }
}
