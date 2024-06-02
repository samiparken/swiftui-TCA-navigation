import Foundation
import ComposableArchitecture

@Reducer
struct ContactsFeature {
  //MARK: - State
  @ObservableState
  struct State: Equatable {
    @Presents var addContact: AddContactFeature.State? //present AddContactFeature (child)
    @Presents var alert: AlertState<Action.Alert>? //present Alert
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  
  //MARK: - Action
  enum Action {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>) //present AddContactFeature (child)
    case deleteButtonTapped(id: Contact.ID)
    
    /// for Alert
    case alert(PresentationAction<Alert>)
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
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
        
        /// replaced with dismiss in child reducer
        //case .addContact(.presented(.cancelButtonTapped)): // for child reducer
        //case .addContact(.presented(.delegate(.cancel))):  //for child-to-parent communication
        //state.addContact = nil
        //return .none
        
        //case .addContact(.presented(.saveButtonTapped)): // for child reducer
      case let .addContact(.presented(.delegate(.saveContact(contact)))): //for child-to-parent communication
        // guard let contact = state.addContact?.contact
        // else { return .none }
        state.contacts.append(contact)
        //state.addContact = nil //replaced with dismiss in child reducer
        return .none
        
      case .addContact: //when AddContactFeature is presented
        return .none
        
      case let .deleteButtonTapped(id: id):
        //Alert
        state.alert = AlertState {
          TextState("Are you sure?")
        } actions: {
          ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
            TextState("Delete")
          }
        }
        return .none
        
      case let .alert(.presented(.confirmDeletion(id: id))):
        state.contacts.remove(id: id)
        return .none
        
      case .alert:
        return .none
        
      }
    }
    // child View
    .ifLet(\.$addContact, action: \.addContact) {  AddContactFeature() }
    // Alert View
    .ifLet(\.$alert, action: \.alert)
  }
}
