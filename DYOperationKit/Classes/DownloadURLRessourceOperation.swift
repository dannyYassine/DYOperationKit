//
//  DownloadURLRessourceOperation.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation
import UIKit

public protocol DownloadURLRessourceOperationProtocol: OperationResponse {}

public class DownloadURLRessourceOperation: DYOperation, DownloadURLRessourceOperationProtocol {
    
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
        if let url = url {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                response = image
            } catch _ {
                finished()
            }
        }
    }
    
}
