//
//  MinuteCandle.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation

struct MinuteCandle: Decodable {
   let market: String
   let kstTime: String
   let openingPrice: Double
   let highPrice: Double
   let lowPrice: Double
   let tradePrice: Double
   
   enum CodingKeys: String, CodingKey {
	  case market
	  case kstTime = "candle_date_time_kst"
	  case openingPrice = "opening_price"
	  case highPrice = "high_price"
	  case lowPrice = "low_price"
	  case tradePrice = "trade_price"
   }
}
