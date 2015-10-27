//
//  SudokuGen.swift
//  MellonDoku
//
//  Created by Gihyuk Ko on 10/27/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

import Foundation

class SudokuGen {
    var difficulty: String
    var puzzle: [[Int]]!
    
    init(difficulty: String) {
        self.difficulty = difficulty
        self.puzzle = genSudoku(difficulty)
    }
    
    func genSudoku(diff: String) -> [[Int]] {
        // todo
        return [[0]]
    }
}