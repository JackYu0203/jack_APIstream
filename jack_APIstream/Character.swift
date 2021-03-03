//
//  Character.swift
//  jack_APIstream
//
//  Created by JackYu on 2021/2/28.
//

import Foundation

struct Character : Codable{
    let data : Data
}

struct Data : Codable {
    let results : [Results]
}

struct Results : Codable {
    let description : String
    let id : Int
    let name : String
    let thumbnail : Thumbnail
}

struct Thumbnail : Codable {
    let path : String
    let `extension` : String
}
