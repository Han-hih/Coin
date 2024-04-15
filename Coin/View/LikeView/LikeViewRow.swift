//
//  LikeViewRow.swift
//  Coin
//
//  Created by 황인호 on 4/14/24.
//

import SwiftUI


struct LikeViewRow: View {
   @State var like: LikeModel
 
    var body: some View {
	   let width = UIScreen.main.bounds.width / 2 - 30
		  RoundedRectangle(cornerRadius: 10, style: .continuous)
			 .fill(.white)
			 .frame(width: width, height: width)
			 .overlay {
				VStack(alignment: .leading) {
				   HStack {
					  Text(like.name)
						 .lineLimit(2)
						 .fontWeight(.semibold)
					  Spacer()
					  HeartButton(name: like.name, code: like.code)
						 .onTapGesture {
							LikeViewModel().action(.likeButtonTapped)
						 }
						 .refreshable {
							LikeViewModel().action(.viewOnAppear)
						 }
				   }
				   Text(like.code)
					  .font(.caption)
				   
				   Spacer().frame(height: 10)
				   
				   Text(like.price)
					  .fontWeight(.semibold)
					  .font(.title3)
				   
				   HStack {
					  Text(like.diff)
					  Text(like.rate)
						 .foregroundStyle(changeColor(value: like.rate))
				   }
				   .minimumScaleFactor(0.5)
				   .lineLimit(1)
				}
				.padding(.horizontal, 10)
			 }
			 .shadow(color: .black.opacity(0.2), radius: 5)
    }
   
   func changeColor(value: String) -> Color {
	  if value.contains("+") {
		 return Color(.red)
	  } else if value.contains("-") {
		 return Color(.blue)
	  } else {
		 return Color(.gray)
	  }
   }
}

