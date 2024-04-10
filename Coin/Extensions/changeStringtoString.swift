//
//  changeStringtoString.swift
//  Coin
//
//  Created by 황인호 on 4/10/24.
//

import Foundation

extension String {
   func formatStringDateToYMDString() -> String {
		   let formatter = DateFormatter()
		   formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		   guard let date = formatter.date(from: self) else {
			   return self
		   }
		   formatter.dateFormat = "yyyy년 MM월 dd일"
		   return formatter.string(from: date)
	   }
}
