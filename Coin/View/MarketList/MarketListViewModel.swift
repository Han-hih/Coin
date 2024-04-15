//
//  MarketListViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation
import Combine

final class MarketListViewModel: ViewModelable {
   
   private var coinList: [CoinList] = []
   private var marketCode: [String] = []
   var coinInfo: [CoinInfo] = []
   // 실시간 검색할 때 사용할 배열
   var realTimeInfo: [CoinInfo] = []
   
   private var cancellables = Set<AnyCancellable>()
   
   private var dataSubject = PassthroughSubject<TickerModel, Never>()
   
   @Published var state: State
   
   enum Action {
	  case marketViewTrigger
	  case search(text: String)
   }
   
   enum State {
	  case coinPrice([CoinInfo])
   }
   
   
   func action(_ action: Action) {
	  switch action {
		 case .marketViewTrigger:
			fetchAllMarket()
			
		 case .search(let text):
			search(text: text)
	  }
   }
   
   init() {
	  state = .coinPrice([CoinInfo(name: "", code: "", rate: "", price: 0.0)])
	  WebSocketManager.shared.tickerSubject
		 .receive(on: DispatchQueue.main)
		 .sink { [weak self] ticker in
			guard let self else { return }
			self.dataSubject.send(ticker)
//						print("🔥", ticker)
			
			if let index = self.coinInfo.firstIndex(where: { $0.code == ticker.code }) {
			   self.coinInfo[index].price = ticker.tradePrice
			   self.coinInfo[index].rate = ticker.changeRate.rateChangeValue(raise: ticker.change)
			   
			   self.updateState()
			}
		 }
		 .store(in: &cancellables)
   }
   
   func fetchAllMarket() {
	  Task {
		 let result = try await UpbitAPI.requestNetwork(model: [CoinList].self, api: .allCoin)
		 switch result {
			case .success(let response):
			   coinList = response
			   coinInfo.removeAll()
			   marketCode.removeAll()
			   realTimeInfo.removeAll()
			   for code in 0..<response.count {
				  marketCode.append(response[code].market)
				  coinInfo.append(CoinInfo(name: response[code].korean, code: response[code].market, rate: "", price: 0.0))
				  realTimeInfo.append(CoinInfo(name: response[code].korean, code: response[code].market, rate: "", price: 0.0))
			   }
			   WebSocketManager.shared.openWebSocket()
			   WebSocketManager.shared.send(codes: marketCode)
			   
			case .failure(let error):
			   print(error)
		 }
	  }
   }
   
   func search(text: String) {
	  let filteredData = realTimeInfo.filter { $0.code.contains(text.uppercased()) || $0.name.contains(text)}
	  print(filteredData)
	  marketCode.removeAll()
	  coinInfo.removeAll()
	  for index in 0..<filteredData.count {
		 marketCode.append(filteredData[index].code)
		 coinInfo.append(
			CoinInfo(
			   name: filteredData[index].name,
			   code: filteredData[index].code,
			   rate: "",
			   price: 0.0
			)
		 )
		 
	  }
	  print(coinInfo.count, marketCode.count)
	  WebSocketManager.shared.openWebSocket()
	  WebSocketManager.shared.send(codes: marketCode)
//	  updateState()
   }
   
   private func updateState() {
	  state = .coinPrice(coinInfo)
   }
   
   deinit {
	  print("디이닛됨")
	  WebSocketManager.shared.closeWebSocket()
   }
}
