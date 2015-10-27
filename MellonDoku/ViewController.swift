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
    
    let screenBound = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diffTitle.center = CGPoint(x: CGRectGetMidX(screenBound), y: CGRectGetMaxY(screenBound) * 0.20)
        playButton.center = CGPoint(x: CGRectGetMaxX(screenBound) * 0.75, y: CGRectGetMaxY(screenBound) * 0.85)
        diffString.center = CGPoint(x: CGRectGetMidX(screenBound), y: CGRectGetMaxY(screenBound) * 0.80)
        easyButton.center = CGPoint(x: CGRectGetMidX(screenBound), y: CGRectGetMaxY(screenBound) * 0.40)
        mediumButton.center = CGPoint(x: CGRectGetMidX(screenBound), y: CGRectGetMaxY(screenBound) * 0.50)
        hardButton.center = CGPoint(x: CGRectGetMidX(screenBound), y: CGRectGetMaxY(screenBound) * 0.60)
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
    
    override func viewDidLoad() {
        // draw puzzle frame
        let framepath = CGPathCreateMutable()
        let puzzleframe = CAShapeLayer()
        
        let initial = (x: CGRectGetMaxX(screenBound) * 0.05,
                       y: (CGRectGetMaxY(screenBound) - CGRectGetMaxX(screenBound)) * 0.6)
        let final = (x: CGRectGetMaxX(screenBound) * 0.95,
                     y: (CGRectGetMaxY(screenBound) - CGRectGetMaxX(screenBound)) * 0.6 + CGRectGetMaxX(screenBound) * 0.9)
        let divide1 = (x: CGRectGetMaxX(screenBound) * 0.35,
                       y: (CGRectGetMaxY(screenBound) - CGRectGetMaxX(screenBound))*0.6 + CGRectGetMaxX(screenBound) * 0.3)
        let divide2 = (x: CGRectGetMaxX(screenBound) * 0.65,
                       y: (CGRectGetMaxY(screenBound) - CGRectGetMaxX(screenBound)) * 0.6 + CGRectGetMaxX(screenBound) * 0.6)
        
        CGPathMoveToPoint(framepath, nil, initial.x, initial.y)
        CGPathAddLineToPoint(framepath, nil, final.x, initial.y)
        CGPathAddLineToPoint(framepath, nil, final.x, final.y)
        CGPathAddLineToPoint(framepath, nil, initial.x, final.y)
        CGPathAddLineToPoint(framepath, nil, initial.x, initial.y)
        CGPathMoveToPoint(framepath, nil, initial.x, divide1.y)
        CGPathAddLineToPoint(framepath, nil, final.x, divide1.y)
        CGPathMoveToPoint(framepath, nil, divide1.x, initial.y)
        CGPathAddLineToPoint(framepath, nil, divide1.x, final.y)
        CGPathMoveToPoint(framepath, nil, divide2.x, initial.y)
        CGPathAddLineToPoint(framepath, nil, divide2.x, final.y)
        CGPathMoveToPoint(framepath, nil, initial.x, divide2.y)
        CGPathAddLineToPoint(framepath, nil, final.x, divide2.y)
        
        puzzleframe.path = framepath
        puzzleframe.lineWidth = 2.0
        puzzleframe.strokeColor = UIColor.blackColor().CGColor
        puzzleframe.fillColor = UIColor.clearColor().CGColor
        self.view.layer.addSublayer(puzzleframe)
        
        // generate sudoku
        sudoku = SudokuGen(difficulty: super.diff)
        
        // print sudoku
        self.printSudoku(sudoku.puzzle)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // do nothing
    }
    override func viewWillDisappear(animated: Bool) {
        // do nothing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func printSudoku(puzzle: [[Int]]) {
        // todo
        // print sudoku
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