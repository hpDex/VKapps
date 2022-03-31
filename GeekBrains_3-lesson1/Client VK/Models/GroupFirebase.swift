//
//  FriendFirebase.swift
//  Client VK
//
//  Created by Denis Filippov on 30.03.2022.
//  Copyright © 2022 Vasily Petuhov. All rights reserved.
//

import Foundation
import FirebaseDatabase


//final class GroupFirebase {
//    let groupID: Int
//    let nameGroup: String
//
//    var ref: DatabaseReference?
//
//    init(groupID: Int, nameGroup: String) {
//        self.groupID = groupID
//        self.nameGroup = nameGroup
//    }
//
//    // дополнительный опциональный инит
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: Any],
//            let groupID = value["groupID"] as? Int,
//            let nameGroup = value["nameGroup"] as? String
//        else { return nil }
//
//        self.groupID = groupID
//        self.nameGroup = nameGroup
//
//        self.ref = snapshot.ref // ссылка на объект
//    }
//
//    func toDictionary() -> [String: Any] {
//        return [String(groupID): nameGroup]
//    }
//
//}
//
