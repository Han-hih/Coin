//
//  LikeViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/14/24.
//

import Foundation
import Combine
import RealmSwift

 class LikeViewModel: ViewModelable {
  
   @Published var marketCode: [String] = []
   @Published var state: State
   
   @ObservedResults(LikeCoinTable.self) var likeLists
   @Published var likeModel: [LikeModel] = []
   
	private var dataSubject = PassthroughSubject<TickerModel, Never>()
   
   private var cancellables = Set<AnyCancellable>()
   
   enum Action {
	  case viewOnAppear
	  case likeButtonTapped
   }
   
   enum State {
	  case coinPrice([LikeModel])
	  
   }
   
   func action(_ action: Action) {
	  switch action {
		 case .viewOnAppear:
			likeModel.removeAll()
			marketCode = likeLists.map { $0.coinCode }
			for code in 0..<likeLists.count {
			   likeModel.append(LikeModel(name: likeLists[code].coinName, code: likeLists[code].coinCode, rate: "", price: "", diff: "", raise: ""))
			}
			
		 case .likeButtonTapped:
			likeModel.removeAll()
			marketCode = likeLists.map { $0.coinCode }
			for code in 0..<likeLists.count {
			   
			   likeModel.append(LikeModel(name: likeLists[code].coinName, code: likeLists[code].coinCode, rate: "", price: "", diff: "", raise: ""))
			}
			updateState()
	  }
   }
   
   init() {
	  state = .coinPrice([LikeModel(name: "", code: "", rate: "", price: "", diff: "", raise: "")])
	
	  WebSocketManager.shared.openWebSocket()
	  WebSocketManager.shared.send(codes: marketCode)
	  WebSocketManager.shared.tickerSubject
		 .receive(on: DispatchQueue.main)
		 .sink { [weak self] ticker in
			guard let self else { return }
			self.dataSubject.send(ticker)
			
			if let index = self.likeModel.firstIndex(where: { $0.code == ticker.code }) {
			   self.likeModel[index].price = ticker.tradePrice.priceChangeValue()
			   self.likeModel[index].rate = ticker.changeRate.rateChangeValue(raise: ticker.change)
			   self.likeModel[index].diff = ticker.changePrice.priceChangeValue().changePriceValue(raise: ticker.change)
			   
			   self.updateState()
			}
		 }
		 .store(in: &cancellables)
   }
   
   private func updateState() {
	  state = .coinPrice(likeModel)
   }
   
   deinit {
	  print("디이닛됨")
	  WebSocketManager.shared.closeWebSocket()
   }
}
