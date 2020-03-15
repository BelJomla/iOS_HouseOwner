//
//  contryCodes.swift
//  BJ_HouseOwner
//
//  Created by Project X on 2/18/20.
//  Copyright © 2020 beljomla.com. All rights reserved.
//

import Foundation


struct codes: Decodable {
    let countryCodes: [item]
}

struct item: Decodable{
    let name: String
    let code: String
    let callingCode: String
}
