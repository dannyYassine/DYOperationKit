//
//  SaveImageCacheRessource.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation
import UIKit

public class SaveImageCacheRessource: DYOperation {
    public var ressource: (image: UIImage?, url: URL?)?
    
    public override func perform() {
        guard let image = ressource?.image, let key = ressource?.url?.absoluteString else {
            finished()
            return
        }
        let data = UIImagePNGRepresentation(image)
        UserDefaults.standard.set(data, forKey: key)
        finished()
    }
    
}
