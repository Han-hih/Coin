//
//  HeartButton.swift
//  Coin
//
//  Created by 황인호 on 4/13/24.
//

import SwiftUI
import RealmSwift

enum Like {
   case like
   case unlike
}

struct HeartButton: View {
   @Environment(\.realm) var realm
   @ObservedResults(LikeCoinTable.self) var likeLists
   
   var name: String
   var code: String
   
   @State private var likeBool: Bool = false
   
   var body: some View {
	  Button {
		 print("좋아요 버튼 눌림")
		 likeToggle(name: name, code: code)
	  } label: {
		 Image(systemName: likeBool ? "heart.fill" : "heart")
			.foregroundColor(.black)
	  }
	  .task {
		 if likeLists.contains(where: { list in
			list.coinCode == code
		 }) {
			likeBool = true
		 }
	  }
   }
   
   private func likeToggle(name: String, code: String) {
	  if likeLists.contains(where: { list in
		 list.coinCode == code
	  }) {
		 print("좋아요 취소")
		 LikeCoinRepository.shared
			.removeItem(
			   LikeCoinTable(
				  coinName: name,
				  coinCode: code
			   )
			)
		 self.likeBool = false
	  } else {
		 print("좋아요 저장")
		 LikeCoinRepository.shared
			.createItem(
			   LikeCoinTable(
				  coinName: name,
				  coinCode: code
			   )
			)
		 self.likeBool = true
	  }
   }
}

   

