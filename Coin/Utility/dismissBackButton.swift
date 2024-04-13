//
//  dismissBackButton.swift
//  Coin
//
//  Created by 황인호 on 4/13/24.
//

import SwiftUI

struct dismissBackButton: View {
   @Environment(\.dismiss) private var dismiss
   
   var body: some View {
	  Button {
		 print("돌아가기")
		 dismiss()
	  } label: {
		 HStack {
			Image(systemName: "chevron.backward")
			   .foregroundColor(.black)
			
		 }
	  }
   }
}
