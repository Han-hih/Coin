//
//  TickerModel.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation

struct TickerModel: Decodable, Hashable {
   let code, change, streamType: String
   let tradePrice, changeRate, changePrice, highPrice, lowPrice, openingPrice, signedChangePrice, signedChangeRate: Double
   
   enum CodingKeys: String, CodingKey {
	  case code, change
	  case streamType = "stream_type"
	  case tradePrice = "trade_price"
	  case changeRate = "change_rate"
	  case changePrice = "change_price"
	  case highPrice = "high_price"
	  case lowPrice = "low_price"
	  case openingPrice = "opening_price"
	  case signedChangePrice = "signed_change_price"
	  case signedChangeRate = "signed_change_rate"
   }
}
