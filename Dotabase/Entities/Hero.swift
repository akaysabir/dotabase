//
//  Hero.swift
//  Dotabase
//
//  Created by zhussupov on 26.05.2021.
//

import Foundation

enum HeroAttribute: String, Codable {
    case agi, int, str
}

enum AttackType: String, Codable {
    case melee = "Melee"
    case ranged = "Ranged"
}

struct Hero: Codable {
    var id: Int?
    var name: String?
    var localized_name: String?
    var primary_attr: HeroAttribute?
    var attack_type: AttackType?
    var legs: Int?
    
    //            "roles": [
    //                "Carry",
    //                "Escape",
    //                "Nuker"
    //            ],
    
}
