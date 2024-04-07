//
//  MarketListRow.swift
//  Coin
//
//  Created by 황인호 on 4/5/24.
//

import SwiftUI

struct MarketListRow: View {
   var coinName: String
   var coinCode: String
   var rate: String
   var price: String
   
   var body: some View {
	  HStack {
		 VStack(alignment: .leading) {
			Text("\(coinName)")
			   .font(.title3)
			
			Text("\(coinCode)")
			   .font(.subheadline)
			   .foregroundStyle(.gray)
		 }
		 Spacer()
		 VStack(alignment: .trailing) {
			Text("\(rate)")
			   .fontWeight(.bold)
			   .foregroundStyle(changeColor(value: rate))
			
			Text("\(price)")
			   .fontWeight(.light)
			   .font(.caption)
			   .foregroundStyle(.gray)
		 }
	  }
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


