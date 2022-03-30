//
//  GroupTableViewController.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import FirebaseDatabase

class GroupTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        subscribeToNotificationRealm() // загрузка данных из реалма (кэш) для первоначального отображения

        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetGroupsList().loadData()
    }
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()
    
    lazy var groupsFromRealm: Results<Group> = {
        return realm.objects(Group.self)
    }()
    
    var notificationToken: NotificationToken?
    
    var myGroups: [Group] = []
    
    // MARK: - Firebase
    
    lazy var database = Database.database()
    lazy var ref: DatabaseReference = self.database.reference(withPath: "Users")
    

    // MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        
        cell.nameGroupLabel.text = myGroups[indexPath.row].groupName
        
        if let imgUrl = URL(string: myGroups[indexPath.row].groupLogo) {
            let avatar = ImageResource(downloadURL: imgUrl) //работает через Kingfisher
            cell.avatarGroupView.avatarImage.kf.indicatorType = .activity //работает через Kingfisher
            cell.avatarGroupView.avatarImage.kf.setImage(with: avatar) //работает через Kingfisher
            
            //cell.avatarGroupView.avatarImage.load(url: imgUrl) // работает через extension UIImageView
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // удаление группы из реалма + обновление таблички из Реалма
            do {
                try realm.write{
                    realm.delete(groupsFromRealm.filter("groupName == %@", myGroups[indexPath.row].groupName))
                }
            } catch {
                print(error)
            }
            

        }
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Functions
    
    private func subscribeToNotificationRealm() {
        notificationToken = groupsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadGroupsFromRealm()
            //case let .update (_, deletions, insertions, modifications):
            case .update:
                self?.loadGroupsFromRealm()

 

            case let .error(error):
                print(error)
            }
        }
    }
    
    func loadGroupsFromRealm() {
            myGroups = Array(groupsFromRealm)
            guard groupsFromRealm.count != 0 else { return } // проверка, что в реалме что-то есть
            tableView.reloadData()
    }
    
    
    // MARK: - Segue
        
        // добавление новой группы из другого контроллера
        @IBAction func addNewGroup(segue:UIStoryboardSegue) {
            // проверка по идентификатору верный ли переход с ячейки
            if segue.identifier == "AddGroup"{
                // ссылка объект на контроллер с которого переход
                guard let newGroupFromController = segue.source as? NewGroupTableViewController else { return }
                // проверка индекса ячейки
                if let indexPath = newGroupFromController.tableView.indexPathForSelectedRow {
                    //добавить новой группы в мои группы из общего списка групп
                    let newGroup = newGroupFromController.GroupsList[indexPath.row]
                    
    //                // проверка что группа уже в списке (нужен Equatable)
                    guard myGroups.description.contains(newGroup.groupName) == false else { return }
                    
                    // добавить новую группу (не нужно, так как все берется из Реалма)
                    //myGroups.append(newGroup)
                    
                    //  добавление новой группы в реалм
                    do {
                        try realm.write{
                            realm.add(newGroup)
                        }
                    } catch {
                        print(error)
                    }
                    
                    // запись в Firebase группы, которую добавил пользователь
                    //let newUserID = UserFirebase(userID: Session.instance.userId)
                    //ref.child(<#T##pathString: String##String#>)
                    //ref.setValue(newUserID.toDictionary())
                }
            }
        }

}
