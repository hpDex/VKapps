//
//  NewGroupTableViewController.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import UIKit


class NewGroupTableViewController: UITableViewController {

    var allGroups = [
        Group(groupName: "Самая лучшая группа", groupLogo: UIImage(named: "group1")),
        Group(groupName: "SWIFT для iOS", groupLogo: UIImage(named: "group2")),
        Group(groupName: "Смешарики", groupLogo: UIImage(named: "group3")),
        Group(groupName: "Веселые картинки", groupLogo: UIImage(named: "group4")),
        Group(groupName: "Умные истории", groupLogo: UIImage(named: "group5"))
    ]

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddGroup", for: indexPath)  as! NewGroupTableViewCell

        cell.nameNewGroupLabel.text = allGroups[indexPath.row].groupName
        cell.avatarNewGroupView.avatarImage.image = allGroups[indexPath.row].groupLogo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // кратковременное подсвечивание при нажатии на ячейку
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
