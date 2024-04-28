//
//  Orderbook.swift
//  Coin
//
//  Created by 황인호 on 4/16/24.
//

import Foundation

/// 호가
struct Orderbook: Decodable, Identifiable {
    let id = UUID()
	let totalAskSize: Double
	let totalBidSize: Double
	let orderbookUnit: [OrderbookUnits]

   enum CodingKeys: String, CodingKey {
	  case totalAskSize = "total_ask_size"
	  case totalBidSize = "total_bid_size"
	  case orderbookUnit = "orderbook_units"
   }
}

/// 매도/매수
struct OrderbookUnits: Identifiable, Decodable {
   let id = UUID()
	let askPrice: Double
	let bidPrice: Double
	let askSize: Double
	let bidSize: Double
   
   enum CodingKeys: String, CodingKey {
	  case askPrice = "ask_price"
	  case bidPrice = "bid_price"
	  case askSize = "ask_size"
	  case bidSize = "bid_size"
   }
}
