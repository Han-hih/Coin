//
//  ChartSection.swift
//  Coin
//
//  Created by 황인호 on 4/13/24.
//

import SwiftUI
import Charts

struct ChartSection: View {
   var chartData: [MinuteCandle] = []
   
   var body: some View {
	  VStack {
		 Chart {
			ForEach(chartData) { item in
//				  LineMark(
//					 x: .value("시간", item.kstTime, unit: .minute),
//					 y: .value("가격", item.tradePrice.priceChangeValue())
//				  )
//				  .foregroundStyle(.green)
				  RectangleMark(
					 x: .value("시간", item.kstTime),
					 yStart: .value("최저가", item.lowPrice),
					 yEnd: .value("최대값", item.highPrice),
					 width: 1
				  )
				  .foregroundStyle(item.openingPrice < item.tradePrice ? .red : .blue)
				  
				  RectangleMark(
					 x: .value("시간", item.kstTime),
					 yStart: .value("최저가", item.openingPrice),
					 yEnd: .value("최대값", item.tradePrice),
					 width: 7
				  )
				  
				  .foregroundStyle(item.openingPrice < item.tradePrice ? .red : .blue)
				  
			   }
		 }
		 .chartForegroundStyleScale(["상승": Color.red, "하락": Color.blue/*, "거래가": Color.green*/])
		 .frame(height: 350)
		 .chartXScale(domain: .automatic(includesZero: false))
		 .chartYScale(domain: .automatic(includesZero: false))
		 .background(.white)
		 .chartScrollableAxes(.horizontal)
		 .safeAreaPadding(.horizontal)
		 .defaultScrollAnchor(.trailing)
		 
			Chart {
			   ForEach(chartData) { item in
//				  LineMark(
//					 x: .value("시간", item.kstTime),
//					 y: .value("판매금액", item.candleTradeVolume)
//				  )
//				  .foregroundStyle(.green)
//				  
				  BarMark(
					 x: .value("시간", item.kstTime),
					 yStart: .value("0", 0),
					 yEnd: .value("판매량", item.candleTradePrice),
					 width: 7
				  )
				  .foregroundStyle(item.openingPrice < item.tradePrice ? .red : .blue)
			   }
			}
			.chartForegroundStyleScale(["거래량": Color.clear])
			.chartXScale(domain: .automatic(includesZero: false))
			.chartYScale(domain: .automatic(includesZero: false))
			.chartScrollableAxes(.horizontal)
			.safeAreaPadding(.horizontal)
			.defaultScrollAnchor(.trailing)
		 }
	  .padding(.bottom, 100)
	  }
	
}
