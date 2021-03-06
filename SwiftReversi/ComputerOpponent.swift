//
//  ComputerOpponent.swift
//  SwiftReversi
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation

class ComputerOpponent: ReversiBoardDelegate {
    private let board: ReversiBoard
    private let color: BoardCellState
    
    init(board: ReversiBoard, color: BoardCellState) {
        self.board = board
        self.color = color
        
        board.addDelegate(self)
    }
    
    func boardStateChanged() {
        if board.nextMove == color {
            delay(1.0) {
                self.makeNextMove()
            }
        }
    }
    
    private func makeNextMove() {
        var bestScore = Int.min
        var bestLocation: BoardLocation?
        board.cellVisitor {
            (location: BoardLocation) in
            if self.board.isValidMove(location) {
                let score = self.scoreForMove(location)
                if (score > bestScore) {
                    bestScore = score
                    bestLocation = location
                }
            }
        }
        if bestScore > Int.min {
            board.makeMove(bestLocation!)
        }
    }
    
    private func scoreForMove(location:BoardLocation) -> Int {
        let testBoard = ReversiBoard(board: board)
        testBoard.makeMove(location)
        let score = color == BoardCellState.White ?
            testBoard.whiteScore - testBoard.blackScore :
            testBoard.blackScore - testBoard.whiteScore
        return score
    }
}

func delay(delay: Double, closure: () -> ()) {
    let time = dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
    )
    dispatch_after(time, dispatch_get_main_queue(), closure)
}
