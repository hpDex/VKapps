//
//  AvatarFriendCollectionViewController.swift
//  Client VK
//
//  Created by DENIS FILIPPOV on 20.02.2022.
//  Copyright © 2022 DENIS FILIPPOV. All rights reserved.
//

import UIKit

class PhotosFriendCollectionViewController: UICollectionViewController {
    
    var collectionPhotos: [UIImage?] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosFriendCell", for: indexPath) as! PhotosFriendCollectionViewCell
        
        let photo = collectionPhotos[indexPath.row]
        cell.photosFrienndImage.image = photo
        
        return cell
    }
    
    // MARK: - segue
    // переход на контроллер с отображением крупной фотографии
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let photosFriend = segue.destination as? FriendsPhotosViewController else { return }
            
            // индекс нажатой ячейки
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                photosFriend.allPhotos = collectionPhotos //фотки
                photosFriend.countCurentPhoto = indexPath.row // indexPath[0][1] если не использовать ?.first выше
            }
        }
    }
    
    
    
}
