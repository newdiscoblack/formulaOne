//
//  ApiResources.swift
//  formula-one
//
//  Created by Kacper Jagiello on 13/04/2021.
//

import Foundation

public protocol HasApiResources {
    var apiResources: ApiResources { get }
}

public protocol ApiResources:
    DriverResources,
    RacingResources { }

public class AppApiResources: ApiResources {
    public init() { }
}
