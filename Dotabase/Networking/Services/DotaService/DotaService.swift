//
//  DotaService.swift
//  Dotabase
//
//  Created by zhussupov on 26.05.2021.
//

import Foundation

final class DotaService: BaseService, DotaServiceProtocol {
    
    func getHeroes(_ completion: @escaping ([Hero]) -> Void) {
        let urlString = "https://api.opendota.com/api/heroes"
        makeRequest(urlString: urlString, completion: completion)
    } 
}
