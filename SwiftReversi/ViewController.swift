//
//  ViewController.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReversiBoardDelegate {
    private let board: ReversiBoard
    private let computer: ComputerOpponent
    
    required init(coder aDecoder: NSCoder) {
        board = ReversiBoard()
        board.setInitialState()
        computer = ComputerOpponent(board: board, color: BoardCellState.Black)
        super.init(coder: aDecoder)
        board.addDelegate(self)
        
    }

    
    @IBOutlet var blackScore : UILabel!
    @IBOutlet var whiteScore : UILabel!
    @IBOutlet var restartButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardFrame = CGRect(x: 88, y: 152, width: 600, height: 600)
        let boardView = ReversiBoardView(frame: boardFrame, board: board)
        view.addSubview(boardView)
        boardStateChanged()
        restartButton.addTarget(self, action: "restartTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func boardStateChanged() {
        blackScore.text = "\(board.blackScore)"
        whiteScore.text = "\(board.whiteScore)"
        //restartButton.hidden = !board.gameHasFinished
        if board.gameHasFinished {
            restartButton.hidden = false
            if board.whiteScore > board.blackScore {
                let alert = UIAlertController(title: "Congratulations!", message: "You are the Winner!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            } else if board.whiteScore < board.blackScore {
                let alert = UIAlertController(title: "Oh, Sorry!", message: "You lost the game!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        }else {
            restartButton.hidden = true
        }
    }
    
    func restartTapped() {
        if board.gameHasFinished {
            board.setInitialState()
            boardStateChanged()
        }
    }
    
}

