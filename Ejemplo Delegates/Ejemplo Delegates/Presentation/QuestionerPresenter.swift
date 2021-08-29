//
//  QuestionerPresenter.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 11/08/21.
//

import UIKit
typealias CallBackBlock<T: Any> = (_ data: T)-> Void
typealias ErrorBlock = (_ error: Error)->Void


class QuestionerPresenter {
    static let instance: QuestionerPresenter = QuestionerPresenter()
    let dataService = DataService.instance
    let converter: QuestionUIConverter = QuestionUIConverter.instance
    var test: Test = Test(numberOfLevels: 5,currentLevel: 0, maxReward: 1000000, accumulatedReward: 0, shots: 2, correctAnswers: 0, gameOver: false)
    
    func getQuestions(onCompletion: @escaping CallBackBlock<[UIQuestion]>, onError: ErrorBlock? ){
        dataService.getQuestions(numberOfLevels: test.numberOfLevels, onCompletion: { questionsData in
            print("1. dataservice callback in presenter: quiestions count \(questionsData.results?.count)")
            onCompletion(self.converter.convert(questionsData))
        }, onError: onError)
    }
    
    func validateAnswer(_ question: UIQuestion)-> Bool {
        return (question.correctAnswer == question.selectedAnswer) ? true : false
    }
    
    func calculateEarnedMoney()-> String{
        test.accumulatedReward += test.rewardPerLevel
        return "$\(test.accumulatedReward)"
    }
    
    func isSelectableCell(_ indexPath: IndexPath)->IndexPath? {
        if indexPath.row == test.currentLevel {
            return indexPath
        }else{
            return nil
        }
    }
        
    func isStillInGame()->Bool{
        return (test.shots == 0) ? false : true
    }
    
    func didWin()->Bool{
        return (test.currentLevel == test.numberOfLevels) ? true : false
    }
    
}
