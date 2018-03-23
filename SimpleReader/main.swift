//
//  main.swift
//  SimpleReader
//
//  Created by Jakob Cederlund on 2018-03-14.
//  Copyright © 2018 dev4phone. All rights reserved.
//

import Foundation

// läs en rad med bråk, skriv ut summan
/*
while true {
    let words = Util.readWords()
    if words.isEmpty {
        break
    }
    let rationals = words.map { word in Rational(string: word) }
    let sum = rationals.reduce(Rational(0), +)
    let product = rationals.reduce(Rational(1), *)
    print("\(rationals)   \(sum)  \(product)  \(Double(rational: sum))")
}*/

func readRationals () -> [Rational] {
    return Util.readWords().map { word in Rational(string: word) }
}

let a = readRationals ()
let b = readRationals ()
let c = MixMax.chop(a, b)
print (c)

