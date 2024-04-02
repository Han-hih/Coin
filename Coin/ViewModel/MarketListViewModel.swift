//
//  MarketListViewModel.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation
import Combine

final class MarketListViewModel: ObservableObject {
   
   @Published var coinList: [CoinInfo] = []
   
   func fetchAllMarket() {
	  Task {
		 let result = try await UpbitAPI.fetchAllMarket(model: [CoinInfo].self)
		 switch result {
			case .success(let response):
			   print(response)
			   coinList = response
			case .failure(let error):
			   print(error)
		 }
	  }
   }
}
