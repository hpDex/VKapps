//
//  GetDataFromVK.swift
//  Client VK
//
//  Created by Denis Filippov on 21.02.2022.
//  Copyright © 2022 Vasily Petuhov. All rights reserved.
//

import Foundation

class GetDataFromVK {
    
    enum parametersAPI {
        case namesAndAvatars
        case photos
        case groups
        case searchGroups
    }
    
    //данные для авторизации в ВК
    func loadData(_ parameters: parametersAPI) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        switch parameters { //изменяющиеся параметры конструктора в зависимости от запроса
        case .namesAndAvatars:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.instance.userId)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "video")) // нужно использовать поисковую фразу
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //            print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) else { return }
            print("Вывод json из ответа: \(String(describing: json))")
            
           
        }
        // запускаем задачу
        task.resume()
    }
    
}
