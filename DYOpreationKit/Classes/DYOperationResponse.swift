//
//  DYOperationResponse.swift
//  OperationExample
//
//  Created by Danny Yassine on 2017-09-04.
//  Copyright © 2017 Danny Yassine. All rights reserved.
//

import Foundation

public protocol OperationResponse {
    associatedtype Response
    var response: Response? { get set }
}
