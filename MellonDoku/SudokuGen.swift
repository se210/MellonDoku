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
        let easySolution: [[Int]] = [[3,2,1,5,8,6,7,4,9],
                                     [9,7,5,3,4,2,1,8,6],
                                     [6,4,8,9,7,1,5,2,3],
                                     [8,1,3,4,5,7,9,6,2],
                                     [5,9,7,2,6,3,8,1,4],
                                     [4,6,2,8,1,9,3,7,5],
                                     [1,8,4,6,9,5,2,3,7],
                                     [2,5,6,7,3,8,4,9,1],
                                     [7,3,9,1,2,4,6,5,8]]
        
        switch (diff) {
        case "Easy":
            return (easyPuzzle, easySolution)
        case "Medium":
            return (mediumPuzzle, solveSudoku(mediumPuzzle))
        case "Hard":
            return (hardPuzzle, solveSudoku(hardPuzzle))
        default:
            return (easyPuzzle, solveSudoku(easyPuzzle))
        }
    }
    
    // a function which checks a number is in the row/column/box
    func checkArray(list: [Int], index: Int) -> Bool {
        for i in 0...8 {
            if (i != index) {
                if (list[i] == list[index]) {
                    return false
                }
            }
        }
        return true
    }
    
    // a function which checks entire puzzle
    func puzzleChecker(puzzle: [[Int]], position: (Int,Int)) -> Bool {
        
        let row: [Int] = puzzle[position.0]
        var column: [Int] = []
        var box: [Int] = []
        let boxposition: (Int,Int) = ((position.0)/3,(position.1)/3)
        let boxindex: Int = (position.1) % 3 + (position.0) % 3 * 3
        
        for i in 0...8 {
            column.append(puzzle[i][position.1])
        }
        for i in 0...2 {
            for j in 0...2 {
                box.append(puzzle[boxposition.0+i][boxposition.1+j])
            }
        }
        checkArray(box, index: boxindex)
        checkArray(row, index: position.1)
        checkArray(column, index: position.0)
        
        if (checkArray(box, index: boxindex) &&
            checkArray(row, index: position.1) &&
            checkArray(column, index: position.0)) {
                return true
        } else {
            return false
        }
    }
    
    // backtrack algorithm to solve a given sudoku puzzle
    func backTrack(puzzle: [[Int]], position: (Int,Int)) -> [[Int]] {
        
        var test: Int = 1
        var modified: [[Int]] = puzzle
        
        if (modified[position.0][position.1] == 0) {
            while (test <= 9) {
                modified[position.0][position.1] = test
                if (puzzleChecker(modified, position: position)) {
                    return modified
                }
                test++
            }
        }
        return puzzle
    }
    
    /*func makeSudoku(puzzle: [[Int]]) -> [[Int]] {
        var nextpuzzle: [[Int]] = puzzle
        for i in 0...8 {
            for j in 0...8 {
                nextpuzzle = backTrack(nextpuzzle, position: (j,i))
            }
        }
        return nextpuzzle
    }*/
    
    //print(makeSudoku(sudoku.puzzle))
    func solveSudoku(puzzle: [[Int]]) -> [[Int]] {
        var nextpuzzle: [[Int]] = puzzle
        for i in 0...8 {
            for j in 0...8 {
                nextpuzzle = backTrack(nextpuzzle, position: (j,i))
            }
        }
        return nextpuzzle
    }
}