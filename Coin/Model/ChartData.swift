//
//  ChartData.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation

// 전일 대비 가격, 전일 대비 등락, 현재가, 마켓코드, 시가, 고가, 저가
struct ChartData {
   let openingPrice: Double
   let highPrice: Double
   let lowPrice: Double
   let tradePrice: Double
   let change: String
   let changePrice: Double
   let changeRate: Double
   let askBid: String
}
