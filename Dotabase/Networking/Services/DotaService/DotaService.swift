//
//  DotaService.swift
//  Dotabase
//
//  Created by zhussupov on 26.05.2021.
//

import Foundation

final class DotaService: BaseService, DotaServiceProtocol {
    
    func getHeroes(_ completion: @escaping ([String: Hero]) -> Void) {
        let urlString = "https://api.opendota.com/api/constants/heroes"
        makeRequest(urlString: urlString, completion: completion)
    }
    
    func getHeroLore(_ completion: @escaping ([String: String]) -> Void) {
        guard let url = URL(string: "https://api.opendota.com/api/constants/hero_lore") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: []) as? [String:String]
                if let lore = jsonResponse {
                    DispatchQueue.main.async {
                        completion(lore)
                    }
                }
//                print(jsonResponse ?? "response error") //Response result
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
}
