//
//  UpbitAPI.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation

enum NetworkError: Error {
   case unknownError
   case decodingError
}

struct UpbitAPI {
   
   private init() { }
   
   static func fetchAllMarket<T: Decodable>(model: T.Type) async throws -> Result<T, NetworkError> {
	  
	  guard let url = URL(string: "https://api.upbit.com/v1/market/all") else { return .failure(.unknownError) }
	  
	  let (data, response) = try await URLSession.shared.data(from: url)
	  
	  guard let httpResponse = response as? HTTPURLResponse,
			httpResponse.statusCode == 200 else {
		 return .failure(.unknownError)
	  }
	  
	  guard let result = try? JSONDecoder().decode(T.self, from: data) else {
		 return .failure(.decodingError)
	  }
	  
	  return .success(result)
   }
   
}
