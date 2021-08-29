//
//  Pessoa.swift
//  students
//
//  Created by Felipe Rocha Oliveira on 09/08/21.
//

import Foundation

enum Genero: String {
    case man = "man"
    case woman = "woman"
}

class People {
    var name: String?
    var lastname: String?
    var age: Int?
    var email: String?
    var genero: Genero?
    var avatar: String?
    var customID: Int?
    
    init(name: String, lastname: String, age: Int, email: String, genero: Genero, avatar: String, customID: Int) {
        self.name = name
        self.lastname = lastname
        self.age = age
        self.email = email
        self.genero = genero
        self.avatar = avatar
        self.customID = customID
    }
}
