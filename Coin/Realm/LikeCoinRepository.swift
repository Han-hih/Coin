//
//  LikeCoinRepository.swift
//  Coin
//
//  Created by 황인호 on 4/14/24.
//

import Foundation
import RealmSwift

protocol ChatListRepositoryType: AnyObject {
	func createItem(_ item: LikeCoinRepository)
    func removeItem(_ item: LikeCoinRepository)
}

class LikeCoinRepository {
   
   static let shared = LikeCoinRepository()
   
   private let realm = try! Realm()
   private init() { }
   
   func checkSchemaVersion() {
	   do {
		   let version = try schemaVersionAtURL(realm.configuration.fileURL!)
		   print("Schema Version: \(version)")
		   
	   } catch {
		   print(error)
	   }
   }
   
   func createItem(_ item: LikeCoinTable) {
	   print(realm.configuration.fileURL!)
	   do {
		   try realm .write {
			   realm.add(item, update: .all)
			   print(realm.configuration.fileURL)
		   }
	   } catch {
		   print(error)
	   }
   }
   
   func removeItem(_ item: LikeCoinTable) {
   //        print(realm.configuration.fileURL)
		   do {
			  guard let task = realm.objects(LikeCoinTable.self).filter({ $0.coinCode == item.coinCode }).first else { return }
			   try realm.write {
				   realm.delete(task)
				   print("제거됨")
			   }
		   } catch {
			   print(error)
		   }
	   }
}
