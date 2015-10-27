//
//  ViewController.swift
//  MellonDoku
//
//  Created by Gihyuk Ko on 10/23/15.
//  Copyright © 2015 Gihyuk Ko. All rights reserved.
//

import UIKit

// Start Screen View Controller Class
class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// Game Setup View Controller Class
class GameSetupViewController: UIViewController {
    
    var diff: String = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func easyDifficulty(sender: AnyObject) {
        diffString.text = "You selected Easy difficulty!"
    }
    
    @IBAction func mediumDifficulty(sender: AnyObject) {
        diffString.text = "You selected Medium difficulty!"
    }
    
    @IBAction func hardDifficulty(sender: AnyObject) {
        diffString.text = "You selected Hard difficulty"
    }
    
    @IBOutlet weak var diffString: UILabel!
    
}

// Game View Controller Class
class GameViewController: GameSetupViewController {
    
    var sudoku: SudokuGen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sudoku = SudokuGen(super.diff)
        self.printSudoku(sudoku.puzzle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func printSudoku(puzzle: [[Int]]) {
        // todo
    }
    
    func checkSolved(puzzle: [[Int]]) {
        // todo
    }
    
    func userInput() {
        // todo
        checkSolved(sudoku.puzzle)
    }
    
}