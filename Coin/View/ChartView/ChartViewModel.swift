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
   var coinName: String
   
   private var dataSubject = PassthroughSubject<TickerModel, Never>()
   
   init(coinCode: String, coinName: String) {
	  self.coinCode = coinCode
	  self.coinName = coinName
	  
	  WebSocketManager.shared.tickerSubject
		 .receive(on: DispatchQueue.main)
		 .sink { [weak self] ticker in
			guard let self else { return }
			self.dataSubject.send(ticker)
			
			if let index = self.chartData.firstIndex(where: { $0.market == ticker.code }) {
			   self.chartData[index].highPrice = ticker.highPrice
			   self.chartData[index].lowPrice = ticker.lowPrice
			   self.chartData[index].tradePrice = ticker.tradePrice
			   self.chartData[index].openingPrice = ticker.openingPrice
			}
			self.chartInfo.name = self.coinName
			self.chartInfo.code = self.coinCode
			self.chartInfo.price = ticker.tradePrice.priceChangeValue()
			self.chartInfo.diff = ticker.changePrice.priceChangeValue()
			self.chartInfo.rate = ticker.changeRate.rateChangeValue(raise: ticker.change)
			self.updateState()
		 }.store(in: &cancellables)
   }
   
   @Published var state: State = .none
   @Published var chartData: [MinuteCandle] = []
   @Published var chartInfo: LikeModel = LikeModel(name: "", code: "", rate: "", price: "", diff: "", raise: "")
   
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
						WebSocketManager.shared.send(codes: [self.coinCode])
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
				  WebSocketManager.shared.openWebSocket()
				  WebSocketManager.shared.send(codes: [self.coinCode])
			   case .failure(let error):
				  promixe(.failure(error))
			}
		 }
	  }
   }
   
   func makeRange() -> [Double] {
	  guard let firstCandle = chartData.first else {
		 return [0, 0]
	  }
	  
	  // 초기값으로 첫 번째 캔들의 highPrice와 lowPrice를 설정
	  var maxHighPrice = firstCandle.highPrice
	  var minLowPrice = firstCandle.lowPrice
	  
	  // 배열을 순회하면서 최대값과 최소값을 갱신
	  for candle in chartData {
		 maxHighPrice = max(maxHighPrice, candle.highPrice)
		 minLowPrice = min(minLowPrice, candle.lowPrice)
	  }
	  
	  return [minLowPrice, maxHighPrice]
   }
   
   private func updateState() {
	  self.state = .chart(chartData)
   }
}
