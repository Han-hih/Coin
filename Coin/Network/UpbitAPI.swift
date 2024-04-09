//
//  UpbitAPI.swift
//  Coin
//
//  Created by 황인호 on 4/2/24.
//

import Foundation

final class UpbitAPI {
   
   private init() { }
   
   static func requestNetwork<T: Decodable>(model: T.Type, api: APIRouter) async throws -> Result<T, NetworkError> {
	  
	  let request = api.task
	  let (data, response) = try await URLSession.shared.data(for: request)
	  
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
