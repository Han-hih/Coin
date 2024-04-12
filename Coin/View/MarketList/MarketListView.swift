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
			NavigationView {
			   VStack {
				  SearchBarView(searchText: "")
				  List {
					 Section {
						ForEach(ticker, id: \.self) { ticker in
						   NavigationLink(destination: ChartView(coinName: ticker.name, coinCode: ticker.code,
							  viewModel: ChartViewModel(coinCode: ticker.code))) {
							  MarketListRow(
								 coinName: ticker.name,
								 coinCode: ticker.code,
								 rate: ticker.rate,
								 price: ticker.price
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
					 viewModel.fetchAllMarket()
				  }
			   }
			   .onDisappear {
				  print("뷰 사라짐")
				  WebSocketManager.shared.closeWebSocket()
			   }
			}
			
	  }
   }
}

