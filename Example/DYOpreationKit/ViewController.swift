//
//  ViewController.swift
//  DYOpreationKit
//
//  Created by dannyyassine on 09/04/2017.
//  Copyright (c) 2017 dannyyassine. All rights reserved.
//

import UIKit
import DYOpreationKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftLeftImageView: UIImageView!
    @IBOutlet weak var rightrightImageView: UIImageView!
    
    let operationQueue: OperationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operation1 = DownloadURLRessourceOperation()
        operation1.url = URL(string: "https://static.pexels.com/photos/34950/pexels-photo.jpg")
        
        //        operation1.completionBlock = { [weak self] in
        //            DispatchQueue.main.async {
        //                self?.leftImageView.image = operation1.response
        //            }
        //        }
        
        let operation2 = DownloadURLRessourceOperation()
        operation2.url = URL(string: "https://cdn.dribbble.com/users/63407/screenshots/3780917/dribbble_aloe_vera_bloom.png")
        
        //        operation2.completionBlock = { [weak self] in
        //            DispatchQueue.main.async {
        //                self?.rightImageView.image = operation2.response
        //            }
        //        }
        
        operation2.addDependency(operation1)
        
        //        operationQueue.addOperation(operation1)
        //        operationQueue.addOperation(operation2)
        
        let groupOperation = DYGroupOperation(withOperations: [operation1, operation2])
        groupOperation.completionBlock = {
            DispatchQueue.main.async {
                self.leftImageView.image = operation1.response
                self.rightImageView.image = operation2.response
            }
        }
        //        operationQueue.addOperation(groupOperation)
        
        let downloadImageRessourceOperation = DownloadImageRessourceOperation(withUrl: URL(string: "https://cdn.dribbble.com/users/63407/screenshots/3780917/dribbble_aloe_vera_bloom.png")!)
        //        downloadImageRessourceOperation.completionBlock = {
        //            DispatchQueue.main.async {
        //                self.leftImageView.image = downloadImageRessourceOperation.response
        //            }
        //        }
        
        let downloadImageRessourceOperation2 = DownloadImageRessourceOperation(withUrl: URL(string: "https://static.pexels.com/photos/34950/pexels-photo.jpg")!)
        //        downloadImageRessourceOperation2.completionBlock = {
        //            DispatchQueue.main.async {
        //                self.rightImageView.image = downloadImageRessourceOperation2.response
        //            }
        //        }
        //        operationQueue.addOperation(downloadImageRessourceOperation)
        //        operationQueue.addOperation(downloadImageRessourceOperation2)
        
        let groupOperation2 = DYGroupOperation(withOperations: [downloadImageRessourceOperation, downloadImageRessourceOperation2])
        groupOperation2.completionBlock = {
            DispatchQueue.main.async {
                self.leftImageView.image = downloadImageRessourceOperation.response
                self.rightImageView.image = downloadImageRessourceOperation2.response
            }
        }
        operationQueue.addOperation(groupOperation2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

