//
//  File.swift
//  SwiftReversi
//
//  Created by mac on 15/9/8.
//  Copyright © 2015年 razeware. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    private var delegates = [T] ()
    
    func addDelegate(delegate: T) {
        delegates.append(delegate)
    }
    
    func invokeDelegates(invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}
