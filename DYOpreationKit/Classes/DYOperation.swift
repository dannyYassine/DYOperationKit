//
//  DYOperation.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation

/// DYOperation 
/// Operation docs:                     https://developer.apple.com/documentation/foundation/operation
/// WWDC 2011 talk for mastering GCD:   https://developer.apple.com/videos/play/wwdc2011/210/
public class DYOperation: Operation {
    
    //MARK: - DYOperation properties
    // https://developer.apple.com/documentation/dispatch/1452917-dispatch_barrier_sync
    var stateQueue: DispatchQueue = DispatchQueue(label: "state",
                                                  qos: DispatchQoS.default,
                                                  attributes: DispatchQueue.Attributes.concurrent,
                                                  autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit,
                                                  target: nil)
    var _state: OperationState = .ready
    private var state: OperationState {
        get {
            return stateQueue.sync(flags: DispatchWorkItemFlags.barrier, execute: { _state })
        }
        set {
            willChangeValue(forKey: "state")
            stateQueue.sync(flags: DispatchWorkItemFlags.barrier, execute: { _state = newValue })
            didChangeValue(forKey: "state")
        }
    }
    
    //MARK: - Operation properties

    public override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished
    }
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    //MARK: - Operation Methods
    
    public override func start() {
        super.start()
        
        if isCancelled {
            state = .finished
            return
        }

        state = .executing
        perform()
    }
    
    public override func main() {
        // not implemented for non-concurrent tasks
    }
    
    //MARK: - DYOperation Methods
    
    func perform() {
        assert(true, "must be implemented by subclass")
    }
    
    public func finished() {
        state = .finished
    }
    
    public func cancelled() {
        state = .cancelled
    }
}

extension DYOperation {
    enum OperationState: Int {
        case ready
        case executing
        case finished
        case cancelled
    }
    
    enum OperationStateKVO: String, RawRepresentable {
        case isReady = "isReady"
        case isExecuting = "isExecuting"
        case isFinished = "isFinished"
        case isCancelled = "isCancelled"
        
        //MARK: - RawRepresentable
        typealias RawValue = String
        
        public init?(rawValue: RawValue) {
            switch rawValue {
            case OperationStateKVO.isReady.rawValue:
                self = .isReady
            case OperationStateKVO.isExecuting.rawValue:
                self = .isExecuting
            case OperationStateKVO.isFinished.rawValue:
                self = .isFinished
            case OperationStateKVO.isCancelled.rawValue:
                self = .isCancelled
            default:
                return nil
            }
        }
        
        public var rawValue: String {
            return self.rawValue
        }
    }
}

// MARK: - NSObject - KVO
/// Reference: https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/Articles/KVODependentKeys.html
extension DYOperation {

    @objc private dynamic class func keyPathsForValuesAffectingIsReady() -> Set<String> {
        return ["state"]
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsExecuting() -> Set<String> {
        return ["state"]
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsFinished() -> Set<String> {
        return ["state"]
    }
    
    @objc private dynamic class func keyPathsForValuesAffectingIsCancelled() -> Set<String> {
        return ["state"]
    }
}
