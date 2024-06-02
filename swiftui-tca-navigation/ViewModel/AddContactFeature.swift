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
      case cancel
      case saveContact(Contact)
    }
  }
  
  //MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .delegate:
        return .none
        
      case .cancelButtonTapped:
        return .send(.delegate(.cancel))
        
      case .saveButtonTapped:
        return .send(.delegate(.saveContact(state.contact)))
        
      case let .setName(name):
        state.contact.name = name
        return .none
        
      }
    }
  }
}
