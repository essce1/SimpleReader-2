//
//  main.swift
//  SimpleReader
//
//  Created by Jakob Cederlund on 2018-03-14.
//  Copyright © 2018 dev4phone. All rights reserved.
//

import Foundation

// läs en rad med bråk, skriv ut summan

while true {
    let words = Util.readWords()
    if words.isEmpty {
        break
    }
    let rationals = words.map { word in Rational(string: word) }
    let sum = rationals.reduce(Rational(0, 1), +)
    print("\(rationals)   \(sum)")
}
