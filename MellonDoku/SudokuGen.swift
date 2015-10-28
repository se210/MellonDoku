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
    var solution: [[Int]]!
    
    init(difficulty: String) {
        self.difficulty = difficulty
        self.puzzle = genSudoku(self.difficulty).puzzle
        self.solution = genSudoku(self.difficulty).solution
    }
    
    func genSudoku(diff: String) -> (puzzle: [[Int]], solution:[[Int]]) {
        // todo
        let easyPuzzle: [[Int]] = [[3,0,1,5,8,6,7,4,9],
                                   [9,7,5,3,4,0,1,0,6],
                                   [6,0,8,0,7,0,5,2,0],
                                   [0,1,0,4,5,7,9,6,2],
                                   [5,0,0,0,0,0,0,0,4],
                                   [4,6,2,8,1,9,0,7,0],
                                   [0,8,4,0,9,0,2,0,7],
                                   [2,0,6,0,3,8,4,9,1],
                                   [7,3,9,1,2,4,6,0,8]]
        let mediumPuzzle: [[Int]] = [[0,0,0,0,0,8,1,4,0],
                                     [0,0,0,0,0,0,9,2,0],
                                     [5,4,9,0,0,0,0,0,0],
                                     [4,0,0,0,8,7,0,0,0],
                                     [7,6,0,1,0,2,0,9,8],
                                     [0,0,0,6,4,0,0,0,2],
                                     [0,0,0,0,0,0,2,8,6],
                                     [0,7,1,0,0,0,0,0,0],
                                     [0,5,2,4,0,0,0,0,0]]
        let hardPuzzle: [[Int]] = [[0,0,0,0,0,0,0,6,8],
                                   [0,9,5,0,0,6,7,0,2],
                                   [0,0,0,0,0,7,0,0,0],
                                   [0,0,0,0,4,5,3,0,0],
                                   [0,5,6,0,3,0,4,1,0],
                                   [0,0,3,8,6,0,0,0,0],
                                   [0,0,0,5,0,0,0,0,0],
                                   [4,0,9,3,0,0,8,5,0],
                                   [5,2,0,0,0,0,0,0,0]]
        
        switch (diff) {
        case "Easy":
            return (easyPuzzle,solveSudoku(easyPuzzle))
        case "Medium":
            return (mediumPuzzle,solveSudoku(mediumPuzzle))
        case "Hard":
            return (hardPuzzle,solveSudoku(hardPuzzle))
        default:
            return ([[0]],[[0]])
        }
    }
    func solveSudoku(puzzle: [[Int]]) -> [[Int]] {
        return [[0]]
    }
}