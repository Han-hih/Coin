//
//  CoinInfo.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation

struct CoinList: Decodable, Hashable {
   var market: String
   var korean: String
   var english: String
   
   enum CodingKeys: String, CodingKey {
	  case market
	  case korean = "korean_name"
	  case english = "english_name"
   }
}

struct CoinInfo: Decodable, Hashable {
   var name: String
   var code: String
   var rate: String
   var price: String
}
