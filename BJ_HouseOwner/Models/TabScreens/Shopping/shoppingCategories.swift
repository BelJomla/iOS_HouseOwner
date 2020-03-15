//
//  shoppingCategories.swift
//  BJ_HouseOwner
//
//  Created by Project X on 3/3/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation

struct shoppingCategories: Decodable{
    let categories: [category]
}

struct category: Decodable {
    let subCategories: [String]
    let name: String
    let picture: String
}
