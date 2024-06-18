//
//  ContactDetailFeature.swift
//  swiftui-tca-navigation
//
//  Created by Han-Saem Park on 2024-06-18.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
  
  //MARK: - State
  @ObservableState
  struct State: Equatable {
    @Presents var alert: AlertState<Action.Alert>?
    let contact: Contact
  }
  
  //MARK: - Action
  enum Action {
    case alert(PresentationAction<Alert>)
    case delegate(Delegate)
    case deleteButtonTapped
    enum Alert {
      case confirmDeletion
    }
    enum Delegate {
      case confirmDeletion
    }
  }
  @Dependency(\.dismiss) var dismiss
  
  //MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .alert(.presented(.confirmDeletion)):
        return .run { send in
          await send(.delegate(.confirmDeletion))
          await self.dismiss()
        }
        
      case .alert:
        return .none
        
      case .delegate:
        return .none
        
      case .deleteButtonTapped:
        state.alert = .confirmDeletion
        return .none
        
      }
    }
    .ifLet(\.$alert, action: \.alert)
        
  }
}

//MARK: - Alert State
extension AlertState where Action == ContactDetailFeature.Action.Alert {
  static let confirmDeletion = Self {
    TextState("Are you sure?")
  } actions: {
    ButtonState(role: .destructive, action: .confirmDeletion) {
      TextState("Delete")
    }
  }
}
