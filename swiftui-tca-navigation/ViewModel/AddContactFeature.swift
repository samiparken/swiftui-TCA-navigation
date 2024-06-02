import ComposableArchitecture

@Reducer
struct AddContactFeature {
  
  //MARK: - State
  @ObservableState
  struct State: Equatable {
    var contact: Contact
  }
  
  //MARK: - Action
  enum Action {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      //case cancel // replaced with dismiss
      case saveContact(Contact)
    }
  }
  
  @Dependency(\.dismiss) var dismiss //dismiss effect for child
  
  //MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .delegate:
        return .none
        
      case .cancelButtonTapped:
        //return .send(.delegate(.cancel)) //for child-to-parent communication
        return .run { _ in await self.dismiss() } //dismiss effect for child
        
      case .saveButtonTapped:
        //return .send(.delegate(.saveContact(state.contact))) //for child-to-parent communication
        return .run { [contact = state.contact] send in
          await send(.delegate(.saveContact(contact))) //for child-to-parent communication
          await self.dismiss() //dismiss effect for child
        }
        
      case let .setName(name):
        state.contact.name = name
        return .none
        
      }
    }
  }
}
