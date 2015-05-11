//
//  ViewController.swift
//  TableViewSample
//
//  Created by ktsukago on 2015/04/28.
//  Copyright (c) 2015年 ktsukago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private enum SectionType:Int {
        case Fruit = 0
        case Vegitable
        case Max
        
        func configure() -> (sectionTitle:String, identifier:String) {
            switch self {
            case .Fruit:
                return ("fruit section", "FruitCell")
            case .Vegitable:
                return ("vegitable section", "VegitableCell")
            case .Max:
                return ("", "")
            }
        }
    }
    
    private let fruitsData = ["apple", "banana", "orange"]
    private let vegitablesData = ["tomato", "carrot"]
}

extension ViewController:UITableViewDelegate {

}

extension ViewController:UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionType.Max.rawValue
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionType(rawValue: section)! {
        case .Fruit:
            return self.fruitsData.count
        case .Vegitable:
            return self.vegitablesData.count
        default:
            println("undefined section")
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = SectionType(rawValue: indexPath.section)!
        
        let (_, identifier) = section.configure()
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell
        
        switch section {
        case .Fruit:
            return self.configureCellForFruitCell(cell as! FruitCell, indexPath: indexPath)
        case .Vegitable:
            return self.configureCellForVegitableCell(cell as! VegitableCell, indexPath: indexPath)
        case .Max:
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Default")
        }

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let (title, _) = SectionType(rawValue: section)!.configure()
        return title
    }
    
    private func configureCellForFruitCell(cell:FruitCell, indexPath:NSIndexPath) -> FruitCell {
        cell.fruitTitleLabel.text = self.fruitsData[indexPath.row]
        return cell
    }
    
    private func configureCellForVegitableCell(cell:VegitableCell, indexPath:NSIndexPath) -> VegitableCell {
        cell.vegitableTitleLabel.text = self.vegitablesData[indexPath.row]
        return cell
    }

}


