import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct ContactsFeature {
  //MARK: - State
  @ObservableState
  struct State: Equatable {
    var contacts: IdentifiedArrayOf<Contact> = []

    //@Presents var addContact: AddContactFeature.State? //present AddContactFeature (child)
    //@Presents var alert: AlertState<Action.Alert>? //present Alert
    @Presents var destination: Destination.State? // for all possible destinations (addContact and alert)
  }
    
  /// All possible Destinations (ContactsFeature can navigate to two possible destinations)
  @Reducer(state: .equatable)
  enum Destination {
    case addContact(AddContactFeature)
    case alert(AlertState<ContactsFeature.Action.Alert>)
  }
  
  //MARK: - Action
  enum Action {
    //case addContact(PresentationAction<AddContactFeature.Action>) //present AddContactFeature (child)
    //case alert(PresentationAction<Alert>)
    case destination(PresentationAction<Destination.Action>) // for addContact and alert
    
    case addButtonTapped
    case deleteButtonTapped(id: Contact.ID)
    
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  
  //MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        

              
//      case .addButtonTapped:
//        state.addContact = AddContactFeature.State(
//          contact: Contact(id: UUID(), name: "")
//        )
//        return .none
        
      case .addButtonTapped:
        state.destination = .addContact(
          AddContactFeature.State(
            contact: Contact(id: UUID(), name: "")
          )
        )
        return .none
                
        
        
        /// replaced with dismiss in child reducer
        //case .addContact(.presented(.cancelButtonTapped)): // for child reducer
        //case .addContact(.presented(.delegate(.cancel))):  //for child-to-parent communication
        //state.addContact = nil
        //return .none
        
        
        
        
        //case .addContact(.presented(.saveButtonTapped)): // for child reducer
//        case let .addContact(.presented(.delegate(.saveContact(contact)))): //for child-to-parent communication
//        guard let contact = state.addContact?.contact
//        else { return .none }
//        state.contacts.append(contact)
        //state.addContact = nil //replaced with dismiss in child reducer
//        return .none
      case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
        state.contacts.append(contact)
        return .none
        
        
        

        
      case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
        state.contacts.remove(id: id)
        return .none
        
      case .destination:
        return .none
        
      case let .deleteButtonTapped(id: id):
        state.destination = .alert(
          AlertState {
            TextState("Are you sure?")
          } actions: {
            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
              TextState("Delete")
            }
          }
        )
        return .none

        
      /// removed after "Destination"
      //case .addContact: //when AddContactFeature is presented
      //return .none

      //case .alert:
      //return .none
        
      }
    }
    // child View
    //.ifLet(\.$addContact, action: \.addContact) {  AddContactFeature() }
    // Alert View
    //.ifLet(\.$alert, action: \.alert)
    // for AddContact and Alert
    .ifLet(\.$destination, action: \.destination)
  }
}
