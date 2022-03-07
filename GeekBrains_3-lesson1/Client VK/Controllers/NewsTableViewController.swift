//
//  NewsTableViewController.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var newsList = [
        PostNewsStruct(name: "Victor", avatar: UIImage(named: "person1"), date: "Вчера в 17:19", textNews: "Телеканал CBS в США утверждает, что Россия отдала приказ войскам о «вторжении» на Украину", textImage: UIImage(named: "news1")),
        PostNewsStruct(name: "Валентин", avatar: UIImage(named: "person2"), date: "20.02.2022 в 14:08", textNews: "Более 53 тысяч беженцев из Донбасса пересекли границу России.", textImage: UIImage(named: "news2")),
        PostNewsStruct(name: "Турин", avatar: UIImage(named: "person3"), date: "20.02.2019 в 14:08", textNews: "Блинкен: США ответят на действия России даже без полномасштабного «вторжения»", textImage: UIImage(named: "news3"))
    ]


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        // аватар
        cell.avatarUserNews.avatarImage.image = newsList[indexPath.row].avatar
        // имя автора
        cell.nameUserNews.text = newsList[indexPath.row].name
        // дата новости
        cell.dateNews.text = newsList[indexPath.row].date
        cell.dateNews.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        cell.dateNews.textColor = UIColor.gray.withAlphaComponent(0.5)
        //текст новости
        cell.textNews.text = newsList[indexPath.row].textNews
        cell.textNews.numberOfLines = 0
        //картинка к новости
        cell.imgNews.image = newsList[indexPath.row].textImage
        cell.imgNews.contentMode = .scaleAspectFill

        return cell
    }

}
