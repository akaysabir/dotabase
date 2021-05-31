//
//  UITableViewExtension.swift
//  Dotabase
//
//  Created by zhussupov on 31.05.2021.
//

import UIKit

extension UITableView {
    func reloadDataAnimated() {
        let range = NSRange(location: 0, length: numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        reloadSections(sections as IndexSet, with: .automatic)
    }
}
