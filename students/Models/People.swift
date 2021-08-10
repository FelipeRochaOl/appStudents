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
    private (set) var name: String?
    private (set) var lastname: String?
    private (set) var age: Int?
    private (set) var email: String?
    private (set) var genero: Genero?
    
    init(name: String, lastname: String, age: Int, email: String, genero: Genero) {
        self.name = name
        self.lastname = lastname
        self.age = age
        self.email = email
        self.genero = genero
    }
}
