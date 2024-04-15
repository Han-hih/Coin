//
//  LikeView.swift
//  Coin
//
//  Created by 황인호 on 4/14/24.
//

import SwiftUI
import RealmSwift

struct LikeView: View {
   
   @ObservedObject private var viewModel = LikeViewModel()
   
   private let columns = [
	  GridItem(.flexible(), spacing: 10),
	  GridItem(.flexible(), spacing: 10)
   ]
   
   var body: some View {
	  switch viewModel.state {
		 case .coinPrice(let array):
			ScrollView {
			   SearchBarView(viewModel: MarketListViewModel())
			   
			   LazyVGrid(columns: columns) {
				  ForEach(array, id: \.self) { ticker in
					 LikeViewRow(like: ticker)
						.padding(.vertical, 5)
				  }
			   }
			   .padding()
			   .onAppear {
				  viewModel.action(.viewOnAppear)
			   }
			}
	  }
   }
   
}

#Preview {
   LikeView()
}
