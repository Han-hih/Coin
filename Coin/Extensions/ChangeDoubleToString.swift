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
	   
	  if self.description.contains("e") {
		  return String(format: "%.8f", self)
	   }
	   
	   if self >= 1 {
		  numberFormatter.numberStyle = .decimal
		  return numberFormatter.string(from: self as NSNumber) ?? "0.0"
	   }
	   
	   if self > 0 && self < 1 {
		  return String(self)
	   }
	   
	   return "No Value"
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
