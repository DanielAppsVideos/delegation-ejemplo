//
//  QuestionsConverter.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 16/08/21.
//

import Foundation

struct UIQuestion {
    let question: String
    let answers: [String]
    let correctAnswer: String
    var selectedAnswer: String?
    var wellAnswered: Bool?
}

class QuestionUIConverter {
    static let instance: QuestionUIConverter = QuestionUIConverter()
    var convertedQuestion: [UIQuestion] = []
    
    func convert(_ questions: Questions)->[UIQuestion] {
//        return convertQuestion(questions)
        guard let questionsData = questions.results else {return []}
        return questionsData.map ({question in
            return convertQuestion(question)
        })
    }

    func convertQuestion(_ questions: QuestionsResults)->UIQuestion {
        if let question = questions.question,
           let correctAnswer = questions.correct_answer,
           var answers = questions.incorrect_answers {
            answers.append(correctAnswer)
            answers.shuffle()
            return UIQuestion(question: question, answers: answers, correctAnswer: correctAnswer)
        }
        return UIQuestion(question: "Error", answers: [], correctAnswer: "")
    }
        
        
//    func convertQuestion(_ questions: Questions)-> [UIQuestion] {
//        guard let questionsArray = questions.results else {return []}
//            for questionElement in questionsArray {
//            guard let question = questionElement.question,
//                  let correctAnswer = questionElement.correct_answer,
//                  var answers: [String] = questionElement.incorrect_answers else {return[]}
//            answers.append(correctAnswer)
//            answers.shuffle()
//            convertedQuestion.append(UIQuestion(question: question, answers: answers, correctAnswer: correctAnswer))
//        }
//        print("ConvertedQuestions UIConverter: count \(convertedQuestion.count)")
//        return convertedQuestion
//    }
}
