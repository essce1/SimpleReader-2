//
//  Rational.swift
//  SimpleReader
//
//  Created by Jakob Cederlund on 2018-03-14.
//  Copyright © 2018 dev4phone. All rights reserved.
//

import Foundation

struct Rational {
    let numerator: Int
    let denominator: Int

    init(_ numerator: Int, _ denominator: Int) {
        assert(denominator > 0)
        (self.numerator, self.denominator) = Rational.minimize(numerator, denominator)
    }

    init(string: String) {
        let split = string.components(separatedBy: "/")
        assert(split.count == 2)
        let numerator = Int(split[0])
        assert(numerator != nil)
        let denominator = Int(split[1])
        assert(denominator != nil)
        assert(denominator! > 0)
        (self.numerator, self.denominator) = Rational.minimize(numerator!, denominator!)
    }

    private static func minimize(_ a: Int, _ b: Int) -> (Int, Int) {
        let gcd = Util.gcd(a, b)
        return (a / gcd, b / gcd)
    }
}

extension Rational {
    static func + (a: Rational, b: Rational) -> Rational {
        return Rational(a.numerator * b.denominator + b.numerator * a.denominator, a.denominator * b.denominator)
    }

    static prefix func - (r: Rational) -> Rational {
        return Rational(-r.numerator, r.denominator)
    }

    static func - (a: Rational, b: Rational) -> Rational {
        return a + -b
    }
}

extension Rational: CustomStringConvertible {
    var description: String {
        return "\(numerator)/\(denominator)"
    }
}
