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
	   Chart {
		  ForEach(chartData) { item in
			 LineMark(
				x: .value("시간", item.kstTime, unit: .minute),
				y: .value("가격", item.tradePrice)
			 )
			 .foregroundStyle(.green)
			 
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
	   .chartXScale(domain: .automatic(includesZero: false))
	   .chartYScale(domain: .automatic(includesZero: false))
	   .background(.white)
	   .chartScrollableAxes(.horizontal)
	   .safeAreaPadding(.horizontal)
    }
}
