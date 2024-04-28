//
//  OrderBookRow.swift
//  Coin
//
//  Created by 황인호 on 4/16/24.
//

import SwiftUI

struct OrderBookRow: View {
   var price: Double
   var percent: String
   var quantity: Double
   var value: Bool
   
   var body: some View {
	  
	  HStack {
		 VStack {
			Text("\(price)")
			   .font(.system(size: 15))
			   .fontWeight(.semibold)
			Text("\(percent)")
			   .font(.system(size: 13))
		 }
		 .padding(.leading)
		 .frame(width: 120, height: 50)
		 .foregroundStyle(value ? .blue : .red)
		 
		 HStack {
			ZStack(alignment: .leading) {
			   
			   Rectangle()
				  .frame(width: 100)
				  .foregroundStyle(.blue)
			   
			   
			   Text("\(quantity)")
				  .foregroundStyle(.black.opacity(0.6))
				  .padding(.leading, 5)
			   
			   Spacer()
			}
			
			Spacer()
		 }
		 .frame(width: 250, height: 50)
		 .background(.blue.opacity(0.6))
		 
		 
		 Spacer()
	  }
   }
}

#Preview {
   OrderBookRow(price: 945.0, percent: "+2.8%", quantity: 21.0, value: true)
}

