//
//  README.swift
//  SwiftReversi
//
//  Created by mac on 15/9/6.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation


struct BoardLocation: Equatable {
    let row: Int, column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
