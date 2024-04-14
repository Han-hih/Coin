//
//  ContentView.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import SwiftUI

enum BottomTab {
   case home, like
}

struct ContentView: View {
   @State var currentTab: BottomTab = .home
   
   var body: some View {
	  ZStack {
		 tabView
		 
		 VStack {
			Spacer()
			bottomTabs
		 }
	  }
   }
}

extension ContentView {
   var tabView: some View {
	  
	  TabView(selection: $currentTab) {
		 MarketListView()
			.tag(BottomTab.home)
			.toolbar(.hidden, for: .tabBar)
			
		 LikeView()
			.tag(BottomTab.like)
	  }
	  .toolbar(.hidden, for: .tabBar)
   }
   
   var bottomTabs: some View {
	  HStack {
		 Spacer()
		 Button {
			self.currentTab = .home
		 } label: {
			VStack(alignment: .center) {
			   Image(systemName: "house")
				  .resizable()
				  .scaledToFit()
				  .frame(width: 30)
			   Text("홈")
				  .font(.system(size: 11))
			}
			   .padding()
		 }
		 Spacer()
		 Button {
			self.currentTab = .like
		 } label: {
			VStack(alignment: .center) {
			   Image(systemName: "heart")
				  .resizable()
				  .scaledToFit()
				  .frame(width: 30)
			   Text("좋아요 목록")
				  .font(.system(size: 11))
			}
			   .padding()
		 }
		 Spacer()
	  }
	  .frame(height: 72)
	  .background {
		 RoundedRectangle(cornerRadius: 30)
			.fill(Color.white)
			.shadow(color: .black.opacity(0.3), radius: 8, y: 2)
	  }
	  .padding(.horizontal)
   }
}

#Preview {
    ContentView()
}
