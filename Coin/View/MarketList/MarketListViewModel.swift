//
//  MarketListViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation
import Combine

final class MarketListViewModel: ObservableObject, ViewModelable {
   
   private var coinList: [CoinList] = []
   private var marketCode: [String] = []
   var coinInfo: [CoinInfo] = []
   
   private var cancellables = Set<AnyCancellable>()
   
   private var dataSubject = CurrentValueSubject<TickerModel, Never>(TickerModel(code: "", change: "", streamType: "", tradePrice: 0.0, changeRate: 0.0))
   
   @Published var state: State
   
   enum Action {
	  case marketViewTrigger
   }
   
   enum State {
	  case coinPrice([CoinInfo])
   }
   
   
   func action(_ action: Action) {
	  switch action {
		 case .marketViewTrigger:
			fetchAllMarket()

	  }
   }
   
   init() {
	  state = .coinPrice([CoinInfo(name: "", code: "", rate: "", price: "")])
	  
	  WebSocketManager.shared.tickerSubject
		 .receive(on: DispatchQueue.main)
		 .sink { [weak self] ticker in
			guard let self else { return }
			self.dataSubject.send(ticker)
			print("🔥", ticker)
			
			if let index = self.coinInfo.firstIndex(where: { $0.code == ticker.code }) {
			   self.coinInfo[index].price = priceChangeValue(value: ticker.tradePrice)
			   self.coinInfo[index].rate = rateChangeValue(value: ticker.changeRate, raise: ticker.change)
			  
			   self.updateState()
			}
		 }
		 .store(in: &cancellables)
   }
   
   func fetchAllMarket() {
	  Task {
		 let result = try await UpbitAPI.fetchAllMarket(model: [CoinList].self)
		 switch result {
			case .success(let response):
			   coinList = response
			   for code in 0..<response.count {
				  marketCode.append(response[code].market)
				  coinInfo.append(CoinInfo(name: response[code].korean, code: response[code].market, rate: "", price: ""))
			   }
			   WebSocketManager.shared.openWebSocket()
			   WebSocketManager.shared.send(codes: marketCode)
			   
			   
			case .failure(let error):
			   print(error)
		 }
	  }
   }
   
   private func updateState() {
	  state = .coinPrice(coinInfo)
   }
   
  private func rateChangeValue(value: Double, raise: String) -> String {
	  var changedValue = ""
	  if raise == "RISE" {
		 changedValue = "+" + String(format: "%.2f", value * 100) + "%"
	  } else if raise == "FALL" {
		 changedValue = "-" + String(format: "%.2f", value * 100) + "%"
	  } else {
		 changedValue = "0.0%"
	  }
	  return changedValue
   }
   
  private func priceChangeValue(value: Double) -> String {
	  let numberFormatter = NumberFormatter()
	  
	  if value.description.contains("e") {
		 return String(format: "%.8f", value)
	  }
	  
	  if value >= 1 {
		 numberFormatter.numberStyle = .decimal
		 return numberFormatter.string(from: value as NSNumber) ?? "0.0"
	  }
	  
	  if value > 0 && value < 1 {
		 return String(value)
	  }
	  
	  return "No Value"
   }
   
   deinit {
	  print("디이닛됨")
	  WebSocketManager.shared.closeWebSocket()
   }
}
