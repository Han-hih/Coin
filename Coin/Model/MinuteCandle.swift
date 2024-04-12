//
//  MinuteCandle.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation

struct MinuteCandle: Decodable, Identifiable {
   let id: UUID = UUID()
   let market: String
   let kstTime: Date
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
   
   init(from decoder: any Decoder) throws {
	  let container = try decoder.container(keyedBy: CodingKeys.self)
	  self.market = try container.decode(String.self, forKey: .market)
	  self.kstTime = try container.decode(String.self, forKey: .kstTime).stringToDate()
	  self.openingPrice = try container.decode(Double.self, forKey: .openingPrice)
	  self.highPrice = try container.decode(Double.self, forKey: .highPrice)
	  self.lowPrice = try container.decode(Double.self, forKey: .lowPrice)
	  self.tradePrice = try container.decode(Double.self, forKey: .tradePrice)
   }
}
