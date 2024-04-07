//
//  MarketListView.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import SwiftUI

struct MarketListView: View {
   
   @StateObject private var viewModel = MarketListViewModel()
   
   var body: some View {
	  switch viewModel.state {
		 case .coinPrice(let ticker):
			List {
			   ForEach(ticker, id: \.self) { ticker in
					 MarketListRow(
						coinName: ticker.name,
						coinCode: ticker.code,
						rate: ticker.rate,
						price: ticker.price
					 )
				  }
			   .listRowSeparator(.hidden)
			}
			.listStyle(.plain)
			.task {
			   viewModel.fetchAllMarket()
			}
	  }
   }
}

