//
//  Films.swift
//  Restaurant App
//
//  Created by Iman Faizal on 30/05/21.
//

import Foundation

struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
