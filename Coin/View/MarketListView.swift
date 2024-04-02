//
//  MarketListView.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import SwiftUI

struct MarketListView: View {
   
   @ObservedObject private var viewModel = MarketListViewModel()
   
	var body: some View {
	   List {
		  ForEach(viewModel.coinList, id: \.self) { data in
			 HStack {
				VStack(alignment: .leading) {
				   Text("\(data.korean)")
					  .font(.title3)
				   
				   Text("\(data.market)")
					  .font(.subheadline)
					  .foregroundStyle(.gray)
				}
				Spacer()
				VStack(alignment: .trailing) {
				   Text("")
					  .fontWeight(.bold)
					  .foregroundStyle(.blue)
				   
				   Text("원")
					  .fontWeight(.light)
					  .font(.caption)
					  .foregroundStyle(.gray)
				}
			 }
			 .listRowSeparator(.hidden)
		  }
	   }
	   .listStyle(.plain)
	   .onAppear {
		  viewModel.fetchAllMarket()
	   }
	}
}
