//
//  Groups.swift
//  Client VK
//
//  Created by Denis Filippov on 02.03.2022.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import RealmSwift

class Group: Object {
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupLogo: String  = ""
    
    init(groupName: String, groupLogo: String) {
        self.groupName = groupName
        self.groupLogo = groupLogo
    }
    
    // этот инит обязателен для Object
    required override init() {
        super.init()
    }
    
    // в классе типа Object не нужно (можно сравнить по дескрипшину)
    // для проведения сравнения (.contains), только по имени
//    static func ==(lhs: Group, rhs: Group) -> Bool {
//        return lhs.groupName == rhs.groupName //&& lhs.groupLogo == rhs.groupLogo
//    }
}
