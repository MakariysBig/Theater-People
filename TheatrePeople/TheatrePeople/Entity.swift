//
//  Entity.swift
//  TheatreScheduler
//
//  Created by Maksim Makarevich on 15.10.23.
//

import Foundation

struct User {
    let firstName: String
    let secondName: String
    let email: String
    let phone: String
    let gender: Gender = .unselected
    let birthday: Date
    let instagram: String
    let telegram: String
    let photo: String
}

enum Gender {
    case male
    case female
    case unselected
}
