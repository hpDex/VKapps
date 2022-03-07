//
//  Groups.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import UIKit

struct Groups: Equatable {
    let groupName: String
    let groupLogo: String
    
    // для проведения сравнения (.contains), только по имени
    static func ==(lhs: Groups, rhs: Groups) -> Bool {
        return lhs.groupName == rhs.groupName //&& lhs.groupLogo == rhs.groupLogo
    }
}
