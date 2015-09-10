//
//  BoardCellState.swift
//  SwiftReversi
//
//  Created by mac on 15/9/6.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation

enum BoardCellState {
    case Empty, Black, White
    
    func invert() -> BoardCellState {
        if self == Black {
            return White
        } else if self == White {
            return Black
        }
        
        assert(self != Empty, "cannot invert the empty state")
        return Empty
    }
}


