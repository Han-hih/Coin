//
//  ChartView.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
   var coinName: String
   var coinCode: String
   
   @StateObject private var viewModel: ChartViewModel
   
   init(coinName: String, coinCode: String, viewModel: ChartViewModel) {
	  self.coinName = coinName
	  self.coinCode = coinCode
	  _viewModel = StateObject(wrappedValue: viewModel)
   }
   
   // x축 기간(시간), y축 가격
   var body: some View {
	  CoinInfoSection(chartInfo: viewModel.chartInfo, coinName: coinName, coinCode: coinCode)
		 
		 //차트뷰
	  ChartSection(chartData: viewModel.chartData)
		 .onAppear {
			viewModel.action(.chartOnAppear)
		 }
		 .navigationBarBackButtonHidden()
		 .toolbar {
			ToolbarItem(placement: .topBarLeading) {
				  DismissBackButton()
			}
			ToolbarItem(placement: .topBarTrailing) {
			   HeartButton(name: coinName, code: coinCode)
			}
		 }
	  }
   }

