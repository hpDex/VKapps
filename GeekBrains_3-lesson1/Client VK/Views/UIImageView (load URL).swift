//
//  UIImageView (load URL).swift
//  Client VK
//
//  Created by Denis Filippov on 02.03.2022.
//  Copyright © 2022 Vasily Petuhov. All rights reserved.
//

import UIKit

// загурзка картинок по URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
