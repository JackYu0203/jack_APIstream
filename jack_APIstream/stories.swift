//
//  stories.swift
//  jack_APIstream
//
//  Created by JackYu on 2021/3/2.
//

import Foundation

struct Stories : Codable {
    let data : data
}

struct data : Codable {
    let results : [results]
}
struct results : Codable {
    let description : String
}

