//
//  File.swift
//  BiRTH
//
//  Created by Hajin on 11/16/24.
//

import Foundation


public class Status: NSObject {
    enum Status: String, Codable {
        case inprogress
        case completed
    }
}
