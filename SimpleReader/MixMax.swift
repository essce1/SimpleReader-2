//
//  mixmax.swift
//  SimpleReader
//
//  Created by Samuel Cederlund on 2018-03-21.
//  Copyright © 2018 dev4phone. All rights reserved.
//

import Foundation


class MixMax {
    static func chop(_ a : [Rational], _ b : [Rational]) -> [Rational] {
        let zero = Rational(0)
        var da = zero, db = zero, ia = 0, ib = 0, na = a.count, nb = b.count
        var result : [Rational] = []
        func bumpA () {
            //print ("bumpA ia \(ia) da \(da) db \(db)");
            result.append(a[ia] - da);
            db = db + a[ia] - da;
            da = zero;
            ia += 1;
            if (ib < nb && b[ib] == db) {
                ib += 1;
                db = zero;
            }
        }
        func bumpB () {
            //print ("bumpB ib \(ib) db \(db) da \(da)");
            result.append(b[ib] - db);
            da = da + b[ib] - db;
            db = zero;
            ib += 1;
            if (ia < na && a[ia] == da) {
                ia += 1;
                da = zero;
            }
        }
        while (true) {
            switch (ia < na, ib < nb) {
            case (false, false): return result
            case (true, false): bumpA()
            case (false, true): bumpB()
            case (true, true):
                if (a[ia] - da <= b[ib] - db) {
                    bumpA()
                } else {
                    bumpB()
                }
            }
        }
    }
    static func select(_ name : String) -> (Rational) -> Rational {
        switch (name) {
        case "proportional" : return { c in Rational(1) }
        case "constant" : return { c in Rational (1) / c }
        default : return { c in Rational(1) }
        }
    }
    static func weights(_ t : [Rational], _ w : [Rational], _ s : [Rational]) -> [Rational] {
        var ai = -1, aleft = Rational(0)
        return s.map ({ so in
            if aleft == Rational(0) {
                ai += 1
                aleft = t[ai]
            }
            aleft = aleft - so
            return w[ai]
        })
    }
    static func removeDuplicates(_ t : [Rational], _ w : [Rational]) -> ([Rational], [Rational]) {
        return (t, w)
    }
    static func iteration(_ f : (Rational) -> Rational, _ atw : ([Rational], [Rational]),
                          _ bt : [Rational]) -> ([Rational], [Rational]) {
        let (at, aw) = atw
        let st = chop(at, bt)
        let bw = bt.map(f)
        let rwa = weights(at, aw, st), rwb = weights(bt, bw, st)    // r as in result
        let rw = zip(rwa, rwb).map(max)
        return removeDuplicates(st, rw)
    }
}
