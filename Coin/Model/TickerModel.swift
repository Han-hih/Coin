//
//  TickerModel.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation

struct TickerModel: Decodable, Hashable {
   let code, change, streamType: String
   let tradePrice, changeRate: Double
   
   enum CodingKeys: String, CodingKey {
	  case code, change
	  case streamType = "stream_type"
	  case tradePrice = "trade_price"
	  case changeRate = "change_rate"
   }
}
