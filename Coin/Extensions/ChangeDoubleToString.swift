//
//  ChangeDoubleToString.swift
//  Coin
//
//  Created by 황인호 on 4/10/24.
//

import Foundation

extension Double {
   func priceChangeValue() -> String {
	   let numberFormatter = NumberFormatter()
	  numberFormatter.maximumFractionDigits = 1
	   
	  if self < 1 {
		 return numberFormatter.string(from: self * 100000000 as NSNumber) ?? ""
	   }
	   
	   if self >= 1000 {
		  numberFormatter.numberStyle = .decimal
		  numberFormatter.maximumFractionDigits = 0
		  return numberFormatter.string(from: self as NSNumber) ?? "0.0"
	   }
	   
	  return String(format: "%.1f", self)
	}
   
   func rateChangeValue(raise: String) -> String {
	   var changedValue = ""
	   if raise == "RISE" {
		  changedValue = "+" + String(format: "%.2f", self * 100) + "%"
	   } else if raise == "FALL" {
		  changedValue = "-" + String(format: "%.2f", self * 100) + "%"
	   } else {
		  changedValue = "0.0%"
	   }
	   return changedValue
	}
   
}
