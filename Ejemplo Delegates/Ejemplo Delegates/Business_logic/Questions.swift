//
//  Questions.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 15/08/21.
//

import Foundation

struct Questions : Decodable {
    let results : [QuestionsResults]?
}

struct QuestionsResults : Decodable {
    let question : String?
    let correct_answer : String?
    let incorrect_answers : [String]?
    
}



