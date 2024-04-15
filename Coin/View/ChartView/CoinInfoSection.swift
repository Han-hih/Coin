//
//  CoinInfoSection.swift
//  Coin
//
//  Created by 황인호 on 4/15/24.
//

import SwiftUI

struct CoinInfoSection: View {
   var chartInfo: LikeModel
   var coinName: String
   var coinCode: String
   
   var body: some View {
	  HStack {
		 VStack(alignment: .leading) {
			HStack {
			   Text("\(coinName)")
				  .font(.title2)
				  .fontWeight(.semibold)
			   Text("(\(coinCode))")
			}
			Text("\(chartInfo.price)원")
			   .font(.title)
			   .fontWeight(.semibold)
			
			HStack {
			   Text("전날보다 \(chartInfo.diff)")
			   Text("(\(chartInfo.rate))")
			}
			.foregroundStyle(changeColor(value: chartInfo.rate))
		 }
		 Spacer()
	  }
	  .safeAreaPadding(.horizontal)
   }
   func changeColor(value: String) -> Color {
	  if value.contains("+") {
		 return Color(.red)
	  } else if value.contains("-") {
		 return Color(.blue)
	  } else {
		 return Color(.gray)
	  }
   }
}

