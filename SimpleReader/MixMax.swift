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
}
