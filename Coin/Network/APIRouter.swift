//
//  APIRouter.swift
//  Coin
//
//  Created by 황인호 on 4/7/24.
//

import Foundation

enum APIRouter {
   case allCoin
   case minuteCandle(unit: Int, code: String)
   case dayCandle
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
		 case .minuteCandle(let unit, _):
			return "/candles/minutes/\(unit)"
		 case .dayCandle:
			return "/candles/days"
	  }
   }

   var method: String {
	  return "GET"
   }
   
   var headers: [String: String]? {
	  switch self {
		 case .allCoin, .dayCandle:
			return nil
		 case .minuteCandle(_, let code):
			return ["market": code]
	  }
   }
   
   var task: URLRequest {
	  let url = baseURL.appendingPathComponent(path)
	  var request = URLRequest(url: url)
	  request.httpMethod = method
	  request.allHTTPHeaderFields = headers
	  return request
   }
}
