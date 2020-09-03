//
// Created by Joel Burton on 9/3/20.
// Copyright (c) 2020 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

struct Point {
    let y: Int
    let x: Int

    var crossAtOrigin: [Point] {
        [
            Point(y: y, x: x),
            Point(y: y - 1, x: x),
            Point(y: y, x: x + 1),
            Point(y: y + 1, x: x),
            Point(y: y, x: x - 1),
        ]
    }
}

extension Int {
    // why most functional languages don't come with this is puzzling; they're obviously
    // not written by Scheme users ;)
    // at least this is a low-cost abstraction and easy to add in Swift
    func times(callback: () -> Void) {
        (0..<self).forEach { _ in callback() }
    }
}

class LightsOut {
    let difficulty: Int
    let numRows: Int
    let numCols: Int

    var grid: [[Bool]]

    init(numRows: Int = 5, numCols: Int = 7, difficulty: Int = 3) {
        self.numRows = numRows
        self.numCols = numCols
        self.difficulty = difficulty

        grid = (0..<numRows).map { row in Array.init(repeating: false, count: numCols) }
        difficulty.times { flipCrossAt(Point(y: Int.random(in: 0..<numRows), x: Int.random(in: 0..<numCols))) }
    }

    func isValidPoint(_ p: Point) -> Bool {
        return p.y >= 0 && p.y < numRows && p.x >= 0 && p.x < numCols
    }

    func flip(_ p: Point) {
        grid[p.y][p.x] = !grid[p.y][p.x]
    }

    func flipCrossAt(_ p: Point) {
        p.crossAtOrigin.filter(isValidPoint).forEach(flip)
    }

    func isWon() -> Bool {
        return grid.allSatisfy({ row in row.allSatisfy({ cell in !cell }) })
    }
}
