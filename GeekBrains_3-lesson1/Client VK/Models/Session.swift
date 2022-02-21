//
//  Session.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    static let instance = Session()
    
    var token = "" // хранение токена в VK
    var userId = 0 // хранение идентификатора пользователя VK
}
