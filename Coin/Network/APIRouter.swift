//
//  APIRouter.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation

enum APIRouter {
   case allCoin
   case minuteCandle(unit: Int, code: String, count: Int)
   case dayCandle
   case orderBook(code: String)
}

extension APIRouter {
   var baseURL: URL {
	  let url = "https://api.upbit.com/v1"
	  return URL(string: url)!
   }
   
   var path: String {
	  switch self {
		 case .allCoin:
			return "/market/all"
		 case .minuteCandle(let unit, _, _):
			return "/candles/minutes/\(unit)"
		 case .dayCandle:
			return "/candles/days"
		 case .orderBook(let code):
			return "/orderbook"
	  }
   }
   
   var method: String {
	  return "GET"
   }
   
   var task: URLRequest {
	  var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
	  switch self {
		 case .minuteCandle(_, let code, let count):
			components.queryItems = [
			   URLQueryItem(name: "market", value: code),
			   URLQueryItem(name: "count", value: "\(count)")
			]
		 case .orderBook(code: let code):
			components.queryItems = [
			URLQueryItem(name: "markets", value: code)
			]
		 default:
			break
	  }
	  
	  components.path.append(path)
	  
	  guard let url = components.url else {
		 fatalError("Invalid URL")
	  }
	  
	  // URLRequest 생성
	  var request = URLRequest(url: url)
	  print(request)
	  return request
   }
}
