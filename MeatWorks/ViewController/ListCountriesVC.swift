//
//  ListCountriesVC.swift
//  Folotrail
//
//  Created by fwThanh on 9/24/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Localize_Swift

class ListCountriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tblCountries: UITableView!
    
    let cellReuseIdentifier = "cell"
    var selectedCountry: ((_ country: Country) -> Void)? = nil
    var selectedUnits: ((_ unit: GroupUnit) -> Void)? = nil
    var listItems = [Country]()
    var listUnits = [GroupUnit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCountries.estimatedRowHeight = 44
        self.tblCountries.rowHeight = UITableViewAutomaticDimension
        // This view controller itself will provide the delegate methods and row data for the table view.
        self.tblCountries.delegate = self
        self.tblCountries.dataSource = self
        self.tblCountries.tableFooterView = UIView()
        self.tblCountries.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listItems.count > 0 {
            return listItems.count
        }
        else if listUnits.count > 0 {
            return listUnits.count
        }
        return 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.numberOfLines = 0
        if listItems.count > 0 {
            cell.textLabel?.text = listItems[indexPath.row].pos_name
        }
        else if listUnits.count > 0 {
            cell.textLabel?.text = listUnits[indexPath.row].unit_name
        }
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.backgroundColor = UIColor.clear
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listItems.count > 0 {
            if (self.selectedCountry != nil) {
                let country = listItems[indexPath.row] as Country
                self.selectedCountry!(country)
            }
        }
        else if listUnits.count > 0 {
            if (self.selectedUnits != nil) {
                let unit = listUnits[indexPath.row] as GroupUnit
                self.selectedUnits!(unit)
            }
        }
    }

}
