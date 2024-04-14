//
//  LikeCoin.swift
//  Coin
//
//  Created by 황인호 on 4/14/24.
//

import Foundation
import RealmSwift

final class LikeCoinTable: Object {
   @Persisted var coinName: String
   @Persisted var coinCode: String
   
   convenience init(coinName: String, coinCode: String) {
	  self.init()
	  self.coinName = coinName
	  self.coinCode = coinCode
   }
}
