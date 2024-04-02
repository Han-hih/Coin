//
//  MarketListView.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import SwiftUI

struct MarketListView: View {
   
   @State private var coins: [CoinInfo] = []
   
	var body: some View {
	   List {
		  ForEach(coins, id: \.self) { coin in
			 HStack {
				VStack(alignment: .leading) {
				   Text("\(coin.coinName)")
					  .font(.title3)
				   
				   Text("\(coin.coinCode)")
					  .font(.subheadline)
					  .foregroundStyle(.gray)
				}
				Spacer()
				VStack(alignment: .trailing) {
				   Text("\(coin.change)")
					  .fontWeight(.bold)
					  .foregroundStyle(.blue)
				   
				   Text("\(coin.price) 원")
					  .fontWeight(.light)
					  .font(.caption)
					  .foregroundStyle(.gray)
				}
			 }
			 .listRowSeparator(.hidden)
		  }
	   }
	   .listStyle(.plain)
	}
}
