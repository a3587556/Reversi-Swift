//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by mac on 15/9/7.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation

class ReversiBoard: Board {
    private (set) var gameHasFinished = false
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    private (set) var blackScore = 0, whiteScore = 0
    
    override init() {
        super.init()
    }
    
    init(board: ReversiBoard) {
        super.init()
        nextMove = board.nextMove
        blackScore = board.blackScore
        whiteScore = board.whiteScore
    }
    
    func setInitialState() {
        clearBoard()
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    private (set) var nextMove = BoardCellState.White
    
    func isValidMove(location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
        if self[location] != BoardCellState.Empty {
            return false
        }
        
        for direction in MoveDirection.directions {
            if moveSurroundsCounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        return false
    }
    
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        for direction in MoveDirection.directions {
            flipOpponentsCounters(location, direction: direction, toState: nextMove)
        }
        //nextMove = nextMove.invert()
        switchTurns()
        gameHasFinished = checkIfGameHasFinished()
        whiteScore = countMatches { self[$0] == BoardCellState.White }
        blackScore = countMatches { self[$0] == BoardCellState.Black }
        reversiBoardDelegates.invokeDelegates { $0.boardStateChanged() }
    }
    
    func checkIfGameHasFinished() -> Bool {
        return !canPlayerMakeMove(BoardCellState.Black) &&
            !canPlayerMakeMove(BoardCellState.White)
    }
    
    private func canPlayerMakeMove(toState: BoardCellState) -> Bool {
        return anyCellsMatchCondition { self.isValidMove($0, toState: toState) }
    }
    
    func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
        while isWithinBounds(currentLocation) {
            let currentState = self[currentLocation]
            if index == 1 {
                // Immediate neighbors must be the opponent’s color
                if currentState != toState.invert() {
                    return false
                }
            } else {
                // if the player’s color is reached, the move is valid
                if currentState == toState {
                    return true
                }
                if currentState == BoardCellState.Empty {
                    return false
                }
            }
            index++
        
            currentLocation = direction.move(currentLocation)
        }
        
        return false
    }
    
    private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
                    // is this a valid move?
        if !moveSurroundsCounters(location,direction: direction, toState: toState) {
            return
        }
        let opponentsState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location
        // flip counters until the edge of the board is reached or // a piece with the current state is reached
        repeat {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }
    
    func addDelegate(delegate: ReversiBoardDelegate) {
                reversiBoardDelegates.addDelegate(delegate)
    }
    
    func switchTurns() {
        var intendedNextMove = nextMove.invert()
        if canPlayerMakeMove(intendedNextMove) {
            nextMove = intendedNextMove
        }
    }
    
    
    
}
