//
//  ChartViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation
import Combine

class ChartViewModel: ViewModelable {
   
   var coinCode: String
   
   init(coinCode: String) {
	  self.coinCode = coinCode
   }
   
   @Published var state: State = .none
   @Published var chartData: [MinuteCandle] = []
   
   private var cancellables = Set<AnyCancellable>()
   
   enum Action {
	  case chartOnAppear
   }
   
   enum State {
	  case none
	  case chart([MinuteCandle])
   }
   
   func action(_ action: Action) {
	  switch action {
		 case .chartOnAppear:
			chartNetworking()
			   .receive(on: DispatchQueue.main)
			   .sink { completion in
				  switch completion {
					 case .failure(let error):
						print(error.localizedDescription)
					 case .finished:
						print("finished")
				  }
			   } receiveValue: { [weak self] (items) in
				  guard let self else {return}
				  self.chartData = items
				  self.updateState()
			   }
			   .store(in: &cancellables)
	  }
   }
   
   
   func chartNetworking() -> Future<[MinuteCandle], Error> {
	  Future { [weak self] (promixe) in
		 guard let self else {return}
		 
		 Task {
			let result = try await UpbitAPI.requestNetwork(
			   model: [MinuteCandle].self,
			   api: .minuteCandle(
				  unit: 3,
				  code: self.coinCode,
				  count: 100
			   )
			)
			switch result {
			   case .success(let response):
				  promixe(.success(response))
				  
			   case .failure(let error):
				  promixe(.failure(error))
			}
		 }
	  }
   }
   
   
   private func updateState() {
		 self.state = .chart(chartData)
   }
}
