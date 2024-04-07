//
//  ViewModelable.swift
//  Coin
//
//  Created by 황인호 on 4/3/24.
//

import SwiftUI
import Combine

protocol ViewModelable: ObservableObject {
  associatedtype Action
  associatedtype State
  
  var state: State { get }
  
  func action(_ action: Action)
}
