//
//  CacheRessourceOperation.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation
import UIKit

public class ImageCacheRessourceOperation: DYOperation, OperationResponse {
    
    public typealias Response = UIImage
    public var response: UIImage? {
        didSet {
            finished()
        }
    }
    
    public var url: URL?

    
    public override func start() {
        if let _ = url {
            super.start()
        } else {
            finished()
        }
    }
    
    public override func perform() {
        guard let key = url?.absoluteString else {
            finished()
            return
        }
        if let data: Data = UserDefaults.standard.object(forKey: key) as? Data {
            response = UIImage(data: data)
        } else {
            response = nil
        }
    }
    
}
