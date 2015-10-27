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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenBounds = UIScreen.mainScreen().bounds
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        startButton.sizeToFit()
        startButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.80)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// Game Setup View Controller Class
class GameSetupViewController: UIViewController {
    
    var diff: String = "Easy"
    
    @IBOutlet weak var diffTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diffTitle.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        playButton.center = CGPoint(x: CGRectGetMaxX(screenBounds) * 0.75, y: CGRectGetMaxY(screenBounds) * 0.85)
        diffString.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.80)
        easyButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.40)
        mediumButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.50)
        hardButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.60)
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
        self.diff = "Easy"
    }
    
    @IBAction func mediumDifficulty(sender: AnyObject) {
        diffString.text = "You selected Medium difficulty!"
        self.diff = "Medium"
    }
    
    @IBAction func hardDifficulty(sender: AnyObject) {
        diffString.text = "You selected Hard difficulty"
        self.diff = "Hard"
    }
    
    @IBOutlet weak var diffString: UILabel!
    
}

// Game View Controller Class
class GameViewController: GameSetupViewController {
    
    var sudoku: SudokuGen!
    @IBOutlet weak var Imageview1: UIImageView!
    
    override func viewDidLoad() {
        sudoku = SudokuGen(difficulty: super.diff)
        self.printSudoku(sudoku.puzzle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func printSudoku(puzzle: [[Int]]) {
        // todo
        // print sudoku
        let screenBounds = UIScreen.mainScreen().bounds
    }
    
    func checkSolved(puzzle: [[Int]]) {
        // todo
        if (puzzle == sudoku.solution) {
            // congratulations!
        }
    }
    
    func userInput() {
        // todo
        // get user input
        checkSolved(sudoku.puzzle)
    }
    
}