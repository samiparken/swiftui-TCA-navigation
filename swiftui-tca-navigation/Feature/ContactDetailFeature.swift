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

  //MARK: - STATE
  @ObservableState
  struct State: Equatable {
    let contact: Contact
  }

  //MARK: - ACTION
  enum Action {

  }
  
  var body: some ReducerOf<Self> {
      Reduce { state, action in
        switch action {
          
        }
      }
    }
}
