//
//  Test.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 20/08/21.
//

import Foundation

struct Test {
    let numberOfLevels: Int
    var currentLevel: Int
    let maxReward: Int
    var rewardPerLevel: Int {return maxReward/numberOfLevels}
    var accumulatedReward: Int 
    var shots: Int
    var correctAnswers:Int
    var gameOver: Bool
    
}
