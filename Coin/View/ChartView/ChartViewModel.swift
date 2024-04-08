//
//  ChartViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation
import Combine

final class ChartViewModel: ObservableObject, ViewModelable {
  
   @Published var state: State
   
   var coinCode = ""
   var chartData = [MinuteCandle]()
   
   
   private var cancellables = Set<AnyCancellable>()
   
   enum Action {
	  case chartOnAppear
   }
   
   enum State {
	  case chart([MinuteCandle])
   }
   
   func action(_ action: Action) {
	  switch action {
		 case .chartOnAppear:
			chartNetworking()
	  }
	  
   }
   
   func chartNetworking() {
	  print("🔥", coinCode)
	  Task {
		 let result = try await UpbitAPI.requestNetwork(
			model: [MinuteCandle].self,
			api: .minuteCandle(
			   unit: 3,
			   code: coinCode,
			   count: 200
			)
		 )
		 switch result {
			case .success(let response):
			   print(response)
			   chartData = response
			case .failure(let error):
			   print(error)
		 }
	  }
   }
   
   
   init() {
	  state = .chart([MinuteCandle(market: "", kstTime: "", openingPrice: 0.0, highPrice: 0.0, lowPrice: 0.0, tradePrice: 0.0)])
   }
}
