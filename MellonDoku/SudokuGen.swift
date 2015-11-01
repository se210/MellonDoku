//
//  SudokuGen.swift
//  MellonDoku
//
//  Created by Gihyuk Ko on 10/27/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import Foundation

class SudokuGen {
    // member variables
    var difficulty: String
    var puzzle: [[Int]] = [[0]]
    var solution: [[Int]] = [[0]]
    
    // an initializer
    init(difficulty: String) {
        self.difficulty = difficulty
        (self.puzzle, self.solution) = genSudoku(self.difficulty)   // generate a sudoku and its solution
    }
    
    // a function which generates sudoku and corresponding solution
    func genSudoku(diff: String) -> (puzzle: [[Int]], solution:[[Int]]) {

        // base seeds for each difficulty
        var easyPuzzle: [[Int]] = [[3,0,1,5,8,6,7,4,9],
                                   [9,7,5,3,4,0,1,0,6],
                                   [6,0,8,0,7,0,5,2,0],
                                   [0,1,0,4,5,7,9,6,2],
                                   [5,0,0,0,0,0,0,0,4],
                                   [4,6,2,8,1,9,0,7,0],
                                   [0,8,4,0,9,0,2,0,7],
                                   [2,0,6,0,3,8,4,9,1],
                                   [7,3,9,1,2,4,6,0,8]]
        var mediumPuzzle: [[Int]] = [[0,0,0,0,0,8,1,4,0],
                                     [0,0,0,0,0,0,9,2,0],
                                     [5,4,9,0,0,0,0,0,0],
                                     [4,0,0,0,8,7,0,0,0],
                                     [7,6,0,1,0,2,0,9,8],
                                     [0,0,0,6,4,0,0,0,2],
                                     [0,0,0,0,0,0,2,8,6],
                                     [0,7,1,0,0,0,0,0,0],
                                     [0,5,2,4,0,0,0,0,0]]
        var hardPuzzle: [[Int]] = [[0,0,0,0,0,0,0,6,8],
                                   [0,9,5,0,0,6,7,0,2],
                                   [0,0,0,0,0,7,0,0,0],
                                   [0,0,0,0,4,5,3,0,0],
                                   [0,5,6,0,3,0,4,1,0],
                                   [0,0,3,8,6,0,0,0,0],
                                   [0,0,0,5,0,0,0,0,0],
                                   [4,0,9,3,0,0,8,5,0],
                                   [5,2,0,0,0,0,0,0,0]]
        
        // generate puzzle according to the difficulty
        switch (diff) {
            
        case "Easy":
            randomizePuzzle(&easyPuzzle)
            var easySolution: [[Int]] = easyPuzzle
            solveSudoku(&easySolution)
            return (easyPuzzle, easySolution)
            
        case "Medium":
            randomizePuzzle(&mediumPuzzle)
            var mediumSolution: [[Int]] = mediumPuzzle
            solveSudoku(&mediumSolution)
            return (mediumPuzzle, mediumSolution)
            
        case "Hard":
            randomizePuzzle(&hardPuzzle)
            var hardSolution: [[Int]] = hardPuzzle
            solveSudoku(&hardSolution)
            return (hardPuzzle, hardSolution)
            
        default:    // will not be called
            return ([[0]],[[0]])
        }
    }
    
    // a function which checks whether it has a duplicate member in an array
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
    
    // check the puzzle if one can put a number in the position
    func isSafe(puzzle: [[Int]], position: (Int,Int), number: Int) -> Bool {
        
        var checker:[[Int]] = puzzle
        checker[position.0][position.1] = number
        let row: [Int] = checker[position.0]
        var column: [Int] = []
        var box: [Int] = []
        let boxposition: (Int,Int) = ((position.0)/3,(position.1)/3)
        let boxindex: Int = (position.1) % 3 + (position.0) % 3 * 3
        
        for i in 0...8 {
            column.append(checker[i][position.1])
        }
        for i in 0...2 {
            for j in 0...2 {
                box.append(checker[3*(boxposition.0)+i][3*(boxposition.1)+j])
            }
        }
        
        return checkArray(box, index: boxindex) &&
               checkArray(row, index: position.1) &&
               checkArray(column, index: position.0)
    }
    
    // find unassigned location for the puzzle
    func findUnassignedLocation(puzzle: [[Int]], inout row: Int, inout col: Int) -> Bool {
        for (row = 0; row < 9; row++) {
            for (col = 0; col < 9; col++) {
                if (puzzle[row][col] == 0) {
                    return true
                }
            }
        }
        return false
    }
    
    // solve sudoku using backtracking algorithm
    func solveSudoku(inout puzzle: [[Int]]) -> Bool {
        
        var row: Int = 0
        var col: Int = 0
        var test: Int = 0
        
        if (!findUnassignedLocation(puzzle, row: &row, col: &col)) {
            return true
        }
        for (test = 1; test <= 9; test++) {
            if (isSafe(puzzle, position: (row,col), number: test)) {
                puzzle[row][col] = test
                if (solveSudoku(&puzzle)) {
                    return true
                }
                puzzle[row][col] = 0
            }
        }
        return false
    }
    
    // randomize puzzle by permutating rows and columns, exchanging symbols in the initial seed
    func randomizePuzzle(inout puzzle: [[Int]]) {
        // randomizing parameters
        let rowperm: [Int] = [Int(arc4random_uniform(6)), Int(arc4random_uniform(6)), Int(arc4random_uniform(6))]
        let colperm: [Int] = [Int(arc4random_uniform(6)), Int(arc4random_uniform(6)), Int(arc4random_uniform(6))]
        let symcount: Int = Int(arc4random_uniform(4))
        var symperm: [(Int,Int)] = []
        
        for i in 0...symcount {
            symperm.append((Int(arc4random_uniform(9)) + 1, Int(arc4random_uniform(9)) + 1))
        }
        
        for i in 0...2 {
            switch (rowperm[i]) {   // 6 different permutations per each row set(in the same box)
            case 1:
                permuteRow(&puzzle, rows: (3*i+1,3*i+2))
            case 2:
                permuteRow(&puzzle, rows: (3*i+0,3*i+1))
            case 3:
                permuteRow(&puzzle, rows: (3*i+0,3*i+1))
                permuteRow(&puzzle, rows: (3*i+0,3*i+2))
            case 4:
                permuteRow(&puzzle, rows: (3*i+0,3*i+1))
                permuteRow(&puzzle, rows: (3*i+1,3*i+2))
            case 5:
                permuteRow(&puzzle, rows: (3*i+0,3*i+2))
            default:
                break
            }
            switch (colperm[i]) {   // 6 different permutations per each column set(in the same box)
            case 1:
                permuteColumn(&puzzle, columns: (3*i+1,3*i+2))
            case 2:
                permuteColumn(&puzzle, columns: (3*i+0,3*i+1))
            case 3:
                permuteColumn(&puzzle, columns: (3*i+0,3*i+1))
                permuteColumn(&puzzle, columns: (3*i+0,3*i+2))
            case 4:
                permuteColumn(&puzzle, columns: (3*i+0,3*i+1))
                permuteColumn(&puzzle, columns: (3*i+1,3*i+2))
            case 5:
                permuteColumn(&puzzle, columns: (3*i+0,3*i+2))
            default:
                break
            }
        }
        for item in symperm {   // symbol permutation
            permuteSymbol(&puzzle, numbers: item)
        }
    }
    
    // permute two rows
    func permuteRow(inout puzzle: [[Int]], rows: (Int,Int)) {
        let temp: [Int] = puzzle[rows.0]
        puzzle[rows.0] = puzzle[rows.1]
        puzzle[rows.1] = temp
    }
    
    // permute two columns
    func permuteColumn(inout puzzle: [[Int]], columns: (Int,Int)) {
        var temp: [Int] = []
        for i in 0...8 {
            temp.append(puzzle[i][columns.0])
            puzzle[i][columns.0] = puzzle[i][columns.1]
        }
        for i in 0...8 {
            puzzle[i][columns.1] = temp[i]
        }
    }
    
    // permute two symbols
    func permuteSymbol(inout puzzle: [[Int]], numbers: (Int,Int)) {
        var index: [(Int,Int)] = []
        for i in 0...8 {
            for j in 0...8 {
                if (puzzle[i][j] == numbers.0) {
                    index.append((i,j))
                }
                if (puzzle[i][j] == numbers.1) {
                    puzzle[i][j] = numbers.0
                }
            }
        }
        for item in index {
            puzzle[item.0][item.1] = numbers.1
        }
    }
}