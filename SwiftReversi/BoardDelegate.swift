//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by mac on 15/9/8.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(location: BoardLocation)
}