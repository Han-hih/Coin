//
//  MarketSelectionView.swift
//  Coin
//
//  Created by 황인호 on 4/10/24.
//

import SwiftUI

struct MarketSelectionView: View {
   var body: some View {
	  HStack(spacing: 0) {
		 Button("KRW") {}
			.foregroundColor(Color.blue)
			.padding(4)
			.padding([.leading, .trailing], 8)
			.border(Color.blue)
			
		 
		 Button("BTC") {}
			.foregroundColor(Color.gray)
			.padding(4)
			.padding([.leading, .trailing], 8)
			.border(Color.gray)
		 
		 Button("ALL") {}
			.foregroundColor(Color.gray)
			.padding(4)
			.padding([.leading, .trailing], 8)
			.border(Color.gray)
		 Spacer()
	  }
	  .safeAreaPadding(.horizontal)
	  
   }
}

#Preview {
   MarketSelectionView()
}
