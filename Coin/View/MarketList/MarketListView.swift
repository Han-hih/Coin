//
//  MarketListView.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import SwiftUI

struct MarketListView: View {
   
   @ObservedObject private var viewModel = MarketListViewModel()
   @State var searchText: String = ""
   
   var body: some View {
	  switch viewModel.state {
		 case .coinPrice(let ticker):
			NavigationView {
			   VStack {
				  SearchBarView(searchText: searchText, viewModel: viewModel)
				  List {
					 Section {
						ForEach(ticker, id: \.self) { ticker in
						   NavigationLink(
							  destination: ChartView(
								 coinName: ticker.name,
								 coinCode: ticker.code,
								 viewModel: ChartViewModel(coinCode: ticker.code, coinName: ticker.name)
							  )
						   ) {
							  MarketListRow(
								 coinName: ticker.name,
								 coinCode: ticker.code,
								 rate: ticker.rate,
								 price: ticker.price.priceChangeValue()
							  )
						   }
						}
						.listRowSeparator(.hidden)
					 } header: {
						MarketListHeaderView()
					 }
				  }
				  .listStyle(.plain)
				  .task {
					 viewModel.action(.marketViewTrigger)
				  }
			   }
			}
	  }
   }
}

