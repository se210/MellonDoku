//
//  ViewController.swift
//  MellonDoku
//
//  Created by Gihyuk Ko on 10/23/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
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
    
    @IBOutlet weak var diffTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    let screenBounds = UIScreen.mainScreen().bounds
    var diff: String?
    
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "difficultyToGame")
        {
            if (self.diff == nil)
            {
                diffString.text = "Difficulty not selected!"
                return false
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == nil)
        {
            return
        }
        
        switch segue.identifier!
        {
            case "difficultyToGame":
                if let gameViewController = segue.destinationViewController as? GameViewController
                {
                    gameViewController.diff = self.diff!;
                }
            default:
            break
        }

    }
    
    
    @IBAction func easyDifficulty(sender: AnyObject) {
        diffString.text = "You selected EASY difficulty."
        diff = "Easy"
    }
    
    @IBAction func mediumDifficulty(sender: AnyObject) {
        diffString.text = "You selected MEDIUM difficulty."
        diff = "Medium"
    }
    
    @IBAction func hardDifficulty(sender: AnyObject) {
        diffString.text = "You selected HARD difficulty."
        diff = "Hard"
    }
    
    @IBOutlet weak var diffString: UILabel!
    
}

// Game View Controller Class
class GameViewController: UIViewController {
    
    var sudoku: SudokuGen!  // sudoku
    var numbers: [UIButton] = [UIButton(type: UIButtonType.Custom) as UIButton] // buttons for the sudoku
    var inputs: [UIButton] = [UIButton(type: UIButtonType.Custom) as UIButton]  // buttons for the user input
    var currentButton: Int = -1 // status indicator for the user input
    var diff: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // draw puzzle frame
        let screenBounds = UIScreen.mainScreen().bounds

        let navibar = self.navigationController!.navigationBar.frame.size.height
        let framepath = CGPathCreateMutable()
        let puzzleframe = CAShapeLayer()
        
        let puzzlesize = CGRectGetMaxX(screenBounds) * 0.9
        let initial = (x: CGRectGetMaxX(screenBounds) * 0.05,
                       y: 0.5 * navibar + (CGRectGetMaxY(screenBounds) - puzzlesize) * 0.5)
        let final = (x: CGRectGetMaxX(screenBounds) * 0.95,
                     y: 0.5 * navibar + (CGRectGetMaxY(screenBounds) - puzzlesize) * 0.5 + puzzlesize)
        let divide1 = (x: CGRectGetMaxX(screenBounds) * 0.35,
                       y: 0.5 * navibar + (CGRectGetMaxY(screenBounds) - puzzlesize) * 0.5 + puzzlesize/3)
        let divide2 = (x: CGRectGetMaxX(screenBounds) * 0.65,
                       y: 0.5 * navibar + (CGRectGetMaxY(screenBounds) - puzzlesize) * 0.5 + 2 * puzzlesize/3)
        
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
        
        let buttonmargin: CGFloat = 3.0
        let buttonsize = puzzlesize / 9 - 2 * buttonmargin
        
        // generate buttons for the sudoku
        for i in 0...8 {
            for j in 0...8 {
                if (i != 0 || j != 0) {
                    numbers.append(UIButton(type: UIButtonType.Custom) as UIButton)
                }
                numbers[9*i+j].frame = CGRectMake(initial.x + buttonmargin + CGFloat(j) * (buttonsize + 2 * buttonmargin),
                                                  initial.y + buttonmargin + CGFloat(i) * (buttonsize + 2 * buttonmargin),
                                                  buttonsize, buttonsize)
                self.view.addSubview(numbers[9*i+j])
            }
        }
        
        // generate buttons for the input
        for i in 0...8 {
            if (i != 0) {
                inputs.append(UIButton(type: UIButtonType.Custom) as UIButton)
            }
            inputs[i].frame = CGRectMake(initial.x + buttonmargin + CGFloat(i) * (buttonsize + 2 * buttonmargin),
                                         final.y + 2 * buttonmargin, buttonsize, buttonsize)
            //inputs[i].backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            inputs[i].tag = i
            self.view.addSubview(inputs[i])
        }
        
        // draw puzzle frame
        puzzleframe.path = framepath
        puzzleframe.lineWidth = 2.0
        puzzleframe.strokeColor = UIColor.blackColor().CGColor
        puzzleframe.fillColor = UIColor.clearColor().CGColor
        self.view.layer.addSublayer(puzzleframe)
        
        // generate sudoku
        sudoku = SudokuGen(difficulty: diff)
        
        // print sudoku
        self.printSudoku(sudoku.puzzle)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // print sudoku
    func printSudoku(puzzle: [[Int]]) {
        for i in 0...8 {
            for j in 0...8 {
                if (puzzle[i][j] != 0) {
                    // print already given numbers
                    let image: String = "melon" + String(puzzle[i][j])
                    numbers[9*i+j].setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
                    numbers[9*i+j].backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
                }
                else {
                    // add actions for numbers not yet completed
                    numbers[9*i+j].tag = 9*i+j
                    numbers[9*i+j].addTarget(self, action: "userInput:", forControlEvents: UIControlEvents.TouchUpInside)
                }
            }
        }
    }
    
    // receive user inputs
    func userInput(sender: UIButton) {
        // if user clicks the slot again, deactivate inputs
        if (currentButton == sender.tag) {
            deactInput()
            currentButton = -1
        }
        // if user clicks the slot for the first time, activate inputs
        else {
            currentButton = sender.tag
            actInput()
        }
    }
    
    // activate input buttons
    func actInput() {
        for i in 0...8 {
            let image: String = "melon" + String(i+1)
            inputs[i].setBackgroundImage(UIImage(named: image), forState:UIControlState.Normal)
            inputs[i].addTarget(self, action: "changeValue:", forControlEvents: UIControlEvents.TouchUpInside)
            inputs[i].backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        }
    }
    
    // deactivate input buttons
    func deactInput() {
        for i in 0...8 {
            inputs[i].setBackgroundImage(nil, forState:UIControlState.Normal)
            inputs[i].removeTarget(self, action: "changeValue:", forControlEvents: UIControlEvents.TouchUpInside)
            inputs[i].backgroundColor = UIColor.clearColor()
        }
    }
    
    // add values to the puzzle as user inputs
    func changeValue(sender: UIButton) {
        sudoku.puzzle[currentButton / 9][currentButton % 9] = sender.tag + 1
        numbers[currentButton].setBackgroundImage(UIImage(named: "melon" + String(sender.tag + 1)), forState: UIControlState.Normal)
        deactInput()
        currentButton = -1
        checkSolved(sudoku.puzzle)
    }
    
    // if the puzzle was solved, print congratulations message
    func checkSolved(puzzle: [[Int]]) {
        if (puzzle == sudoku.solution) {
            let alertController = UIAlertController(title: "Congratulations!",
                message: "You have beat " + diff + " difficulty puzzle!",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}