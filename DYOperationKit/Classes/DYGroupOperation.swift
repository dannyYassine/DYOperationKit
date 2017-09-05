//
//  DYGroupOperation.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation

public class DYGroupOperation: DYOperation {
    
    let operationQueue: OperationQueue = OperationQueue()
    private let completionOperation: BlockOperation = BlockOperation()
    var operations: [Operation] = []
    
    public init(withOperations operations: [Operation]) {
        super.init()
        
        completionOperation.addExecutionBlock {
            self.finished()
        }
        self.operations = operations
        operations.forEach({ completionOperation.addDependency($0) })
    }
    
    public override func perform() {
        var operations = self.operations
        operations.append(completionOperation)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
}
