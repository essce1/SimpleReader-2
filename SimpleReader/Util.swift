//
//  Util.swift
//  SimpleReader
//
//  Created by Jakob Cederlund on 2018-03-14.
//  Copyright © 2018 dev4phone. All rights reserved.
//

import Foundation

class Util {
    static func gcd(_ u: Int, _ v: Int) -> Int {
        assert(u >= 0)
        assert(v >= 0)
        // simple cases (termination)
        if u == v {
            return u
        }
        if u == 0 {
            return v
        }
        if (v == 0) {
            return u
        }
        // look for factors of 2
        if (u & 1) == 0 { // u is even
            if (v & 1) != 0 { // v is odd
                return gcd(u >> 1, v)
            } else { // both u and v are even
                return gcd(u >> 1, v >> 1) << 1
            }
        } else { // u is odd
            if (v & 1) == 0 { // u is odd, v is even
                return gcd(u, v >> 1)
            }
        }
        // reduce larger argument
        if u > v {
            return gcd((u - v) >> 1, v)
        } else {
            return gcd((v - u) >> 1, u);
        }
    }

    static func readWords() -> [String] {
        guard let line = readLine() else {
            return []
        }
        return line.components(separatedBy: " ").filter { s in !s.isEmpty }
    }
}
