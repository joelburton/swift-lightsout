//
//  main.swift
//  lightsout
//
//  Created by Joel Burton on 9/3/20.
//  Copyright © 2020 Joel Burton. All rights reserved.
//

import Foundation

var game = LightsOut()

func getMove() -> Point {
    while true {
        print("Move? (row col) ", terminator: "")
        if let input = readLine() {
            let vals = input.split(separator: " ").map { Int($0) }
            if vals.count == 2 && vals[0] != nil && vals[1] != nil {
                return Point(y: vals[0]!, x: vals[1]!)
            }
        }
    }
}

func printBoard() {
    print("  ", (0..<game.numCols).map { String($0) }.joined(separator: "  "))
    for (index, row) in game.grid.enumerated() {
        print(index, "", row.map { $0 ? "X" : "-" }.joined(separator: "  "))
    }
}

while !game.isWon() {
    printBoard()
    let point = getMove()
    game.flipCrossAt(point)
}
