//
//  ChartSection.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import SwiftUI
import Charts

struct ChartSection: View {
   var name: String
   var code: String
   var price: String
   var rate: String
   var comparedPrice: String
   
   // x축 time: kstTime, y축 price: tradePrice
   var data: [MinuteCandle]

   var body: some View {
	  GroupBox {
		 HStack {
			VStack(alignment: .leading) {
			  LazyHStack {
				  Text("\(name)")
					 .font(.title2)
					 .fontWeight(.semibold)
				  
				  Text("(\(code))")
			   }
			   
			   Text("\(price)")
				  .font(.title)
				  .fontWeight(.semibold)
			   
			   Text("전날보다 \(comparedPrice)원(\(rate))")
			}
			Spacer()
		 }
		 
		 Chart(data, id: \.kstTime) {
			LineMark(
			   x: .value("시간", $0.kstTime),
			   y: .value("가격", $0.tradePrice)
			)
		 }
		 .chartYScale(domain: (data.first?.lowPrice ?? 0.0)...(data.first?.highPrice ?? 0.0))
	  }
   }
}

#Preview {
   ChartSection(name: "테슬라", code: "BTC-ABC", price: "123,123원", rate: "+2.8%", comparedPrice: "1,023", data: ChartViewModel().chartData)
}
