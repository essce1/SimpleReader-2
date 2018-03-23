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

    init(_ int: Int) {
        self.init(int, 1)
    }

    init(string: String) {
        //print("string \(string)");
        let split = string.components(separatedBy: "/")
        assert((1...2).contains(split.count) )
        let numerator = Int(split[0])
        let denominator = split.count == 2 && numerator != 0 ? Int(split[1]) : 1
        assert(denominator != nil)
        self.init(numerator!, denominator!)
    }

    private static func minimize(_ a: Int, _ b: Int) -> (Int, Int) {
        let gcd = Util.gcd(abs(a), b)
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

    static func * (a: Rational, b: Rational) -> Rational {
        return Rational(a.numerator * b.numerator, a.denominator * b.denominator)
    }

    static func / (a: Rational, b: Rational) -> Rational {
        return Rational(a.numerator * b.denominator, a.denominator * b.numerator)
    }
}

extension Rational: CustomStringConvertible {
    var description: String {
        return denominator > 1 ? "\(numerator)/\(denominator)" : "\(numerator)"
    }
}

extension Double {
    init(rational: Rational) {
        self.init(Double(rational.numerator) / Double(rational.denominator))
    }
}

extension Float {
    init(rational: Rational) {
        self.init(Float(rational.numerator) / Float(rational.denominator))
    }
}

extension Rational: Equatable {
    static func ==(lhs: Rational, rhs: Rational) -> Bool {
        return rhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }
    
}
extension Rational : Comparable {
    static func <(lhs: Rational, rhs: Rational) -> Bool {
        return lhs.numerator * rhs.denominator < rhs.numerator * lhs.denominator
    }
    
}

