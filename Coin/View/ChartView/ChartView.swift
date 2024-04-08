//
//  ChartView.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import SwiftUI
import Charts

//struct ChartData {
//   
//}

struct ChartView: View {
   @State var coinName = ""
   @State var coinCode = ""
   
   @StateObject var viewModel = ChartViewModel()
   
   // x축 기간(시간), y축 가격
   var body: some View {
	  ChartSection(
		 name: coinName,
		 code: coinCode,
		 price: "",
		 rate: "",
		 comparedPrice: "",
		 data: viewModel.chartData
	  )
	  
	  
		 .task {
			print(coinCode)
			viewModel.coinCode = coinCode
			viewModel.chartNetworking()
		 }
   }
}
   


#Preview {
   ChartView()
}
