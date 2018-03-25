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
    static func select(_ name : String) -> (Int, Rational, Rational) -> Rational {
        switch (name) {
        case "proportional" : return { i, t, c in Rational(1) }
        case "constant" : return { i, t, c in Rational (1) / c }
        default : return { i, t, c in Rational(1) }
        }
    }
    static func weights(_ t : [Rational], _ w : [Rational], _ s : [Rational]) -> [Rational] {
        var ai = -1, aleft = Rational(0)
        return s.map ({ so in
            if aleft == Rational(0) && ai + 1 < t.count {
                ai += 1
                aleft = t[ai]
            }
            aleft = aleft - so
            return w[ai]
        })
    }
    static func iteration(_ f : (Int, Rational, Rational) -> Rational,
                          _ atw : ([Rational], [Rational]),
                          _ bt : [Rational], _ order : Int) -> ([Rational], [Rational]) {
        let (at, aw) = atw
        let st = chop(at, bt)
        var tcount = Rational(0), bw : [Rational] = []
        for t in bt {
            bw.append(f(order, tcount, t))
            tcount = tcount + t
        }
        let rwa = weights(at, aw, st), rwb = weights(bt, bw, st)    // r as in result
        let rw = zip(rwa, rwb).map(max)
        //print("iteration atw \(atw) bt \(bt) st \(st) rw \(rw)")
        return (st, rw)
    }
    static func applyOne(_ st : [Rational], _ sw : [Rational], _ at : [Rational]) -> [Rational] {           // a bit ugly
        //print("applyOne st \(st) sw \(sw) at \(at)")
        var aleft = at[0], ai = 0
        var aw : [Rational] = [], w = Rational(0)
        zip(st, sw).forEach({ sto, swo in
            //print ("sto \(sto) aleft \(aleft)")
            w = w + swo
            if aleft == sto {
                //print ("append \(w)")
                aw.append(w)
                ai += 1
                aleft = ai >= at.count ? Rational(-1) : at[ai] + sto
                w = Rational(0)
            }
            aleft = aleft - sto
        })
        //print ("aw \(aw)")
        return aw
    }
    static func apply(_ st : [Rational], _ sw : [Rational], _ ts : [[Rational]]) -> [[Rational]] {
        return ts.map({ at in return applyOne(st, sw, at) })
    }
    static func iterate(_ fName : String, _ ts : [[Rational]]) -> [[Rational]] {
        return iterate(select(fName), ts)
    }
    static func iterate(_ f : (Int, Rational, Rational) -> Rational, _ ts : [[Rational]]) -> [[Rational]] {
        let t = ts.first!.reduce(Rational(0), +)
        var order = -1
        let (st, rw) = ts.reduce(([t], [Rational(0)]), { r, e in
            order += 1
            return iteration(f, r, e, order)
        })
        return apply(st, zip(st, rw).map(*), ts)
    }
    static func widen(_ start : Rational, _ length : Rational, _ w : Rational, _ old : [[Rational]]) -> [[Rational]] {
        let olen = old[0].reduce(Rational(0), +)
        var cold = old
        assert(olen >= start + length)
        func f (_ order : Int, tcount : Rational, dt : Rational) -> Rational {
            return order == 0 ? (tcount == start ? w : Rational(0)) : Rational(1)
        }
        let nt = [start, length, olen - length - start]
        cold.insert(nt, at: 0)
        var result = iterate(f, cold)
        result.removeFirst()
        return result
    }
}
