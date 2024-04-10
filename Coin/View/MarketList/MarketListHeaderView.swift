//
//  MarketListHeaderView.swift
//  Coin
//
//  Created by 황인호 on 4/10/24.
//

import SwiftUI

struct MarketListHeaderView: View {
   var body: some View {
	  HStack {
		 Text("코인명")
			.font(.caption)
		 Spacer()
		 Text("    등락(%)/\n현재가(KRW)")
			.font(.caption2)
	  }
	  .safeAreaPadding(.horizontal)
   }
}

#Preview {
    MarketListHeaderView()
}
