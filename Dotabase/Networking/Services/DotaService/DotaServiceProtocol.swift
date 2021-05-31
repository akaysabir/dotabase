//
//  DotaServiceProtocol.swift
//  Dotabase
//
//  Created by zhussupov on 26.05.2021.
//

protocol DotaServiceProtocol {
    func getHeroes(_ completion: @escaping ([Hero]) -> Void)
    func getHeroLore(_ completion: @escaping (([String: String]) -> Void))
}
