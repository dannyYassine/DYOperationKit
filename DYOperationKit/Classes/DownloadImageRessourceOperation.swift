//
//  DownloadImageRessourceOperation.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation
import UIKit

public class DownloadImageRessourceOperation: DYOperation {
    
    var getImageCacheOperation: ImageCacheRessourceOperation
    var downloadURLRessourceOperation: DownloadURLRessourceOperation
    var saveImageCacheRessource: SaveImageCacheRessource
    
    public typealias Response = UIImage
    public var response: UIImage? {
        didSet {
            finished()
        }
    }
    var url: URL
    var operationQueue: OperationQueue = OperationQueue()
    public init(withUrl url: URL) {
        self.url = url
        getImageCacheOperation = ImageCacheRessourceOperation()
        downloadURLRessourceOperation = DownloadURLRessourceOperation()
        saveImageCacheRessource = SaveImageCacheRessource()
        super.init()
        
        getImageCacheOperation.url = url
        
    }
    
    public override func perform() {
        
        let blockCache = BlockOperation { [weak self] in
            if let image = self?.getImageCacheOperation.response {
                self?.response = image
                self?.operationQueue.cancelAllOperations()
            } else {
                self?.downloadURLRessourceOperation.request = self?.url
            }
        }
        
        let blockDownloadURL = BlockOperation { [weak self] in
            let ressource = (self?.downloadURLRessourceOperation.response, self?.url)
            self?.saveImageCacheRessource.ressource = ressource
        }
        
        let blockSaveImageCache = BlockOperation { [weak self] in
            self?.response = self?.downloadURLRessourceOperation.response
        }
        
        blockCache.addDependency(getImageCacheOperation)
        blockDownloadURL.addDependency(downloadURLRessourceOperation)
        
        downloadURLRessourceOperation.addDependency(blockCache)
        
        saveImageCacheRessource.addDependency(blockDownloadURL)
        
        blockSaveImageCache.addDependency(saveImageCacheRessource)
        
        operationQueue.addOperations([blockCache, blockDownloadURL, downloadURLRessourceOperation, getImageCacheOperation, saveImageCacheRessource, blockSaveImageCache], waitUntilFinished: false)
        
    }
    
}
