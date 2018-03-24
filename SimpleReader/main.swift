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

let f = readLine()
var ts : [[Rational]] = []
while true {
    let words = Util.readWords()
    if words.isEmpty {
        break
    }
    ts.append(words.map { word in Rational(string: word) })
}
print(MixMax.iterate(f!, ts))
/*let at = readRationals(), aw = readRationals(), bt = readRationals()
print(MixMax.iteration(MixMax.select(f!), (at, aw), bt))
let b = readRationals ()
let c = MixMax.chop(a, b)
print (a.map(MixMax.select(f!)))
let t = readRationals(), w = readRationals(), s = readRationals()
print (MixMax.weights(t, w, s))
 */
let st = readRationals(), sw = readRationals(), at = readRationals()
//let st = [Rational(1, 3), Rational(1, 3), Rational(1, 3)]
//let sw = [Rational(1), Rational(1, 2), Rational(1)]
//let at = [Rational(1, 3), Rational(1, 3), Rational(1, 3)]
print (MixMax.applyOne(st, sw, at))

