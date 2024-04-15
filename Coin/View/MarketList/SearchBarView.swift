//
//  SearchBarView.swift
//  Coin
//
//  Created by 황인호 on 4/10/24.
//

import SwiftUI

struct SearchBarView: View {
   @State var searchText: String = ""
   @StateObject var viewModel: MarketListViewModel
   
   var body: some View {
	  HStack {
		 Image(systemName: "magnifyingglass")
			.foregroundColor(
			   searchText.isEmpty ?
			   Color.gray : Color.black)
		 TextField("코인명 / 심볼 검색", text: $searchText)
			.onChange(of: searchText) {
			   if searchText.isEmpty {
				  print("🥹", searchText)
				  viewModel.action(.marketViewTrigger)
			   } else {
				  viewModel.action(.search(text: searchText))
			   }
			}
			.autocorrectionDisabled(true)
			.foregroundColor(Color.black)
			.overlay(
			   Image(systemName: "xmark.circle.fill")
				  .padding()
				  .offset(x: 10)
				  .foregroundColor(Color.black)
				  .opacity(searchText.isEmpty ? 0.0 : 1.0)
				  .onTapGesture {
					 searchText = ""
					 UIApplication.shared.endEditing()
				  }
			   , alignment: .trailing
			)
	  }
	  .font(.headline)
	  .padding()
	  .background(
		 RoundedRectangle(cornerRadius: 25)
			.fill(Color.white)
			.shadow(
			   color: Color.black.opacity(0.3),
			   radius: 10, x: 0, y: 0)
	  )
	  	  .padding()
   }
}
extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
