//
//  ModelQuiz.swift
//  TrueFalseStarter
//
//  Created by Gary Luce on 01/07/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class Trivia {
    var question: String
    var answer: String
    var guess1: String
    var guess2: String
    var guess3: String
    
    init(question: String, answer: String, guess1: String, guess2: String, guess3: String) {
        self.question = question
        self.answer = answer
        self.guess1 = guess1
        self.guess2 = guess2
        self.guess3 = guess3
    }
}

let trivia1 = Trivia(question: "Who was the CEO of Apple in 1978?", answer: "Michael Scott", guess1: "Steve Jobs", guess2: "Jean-Louis Gasse", guess3: "Tim Cook")
let trivia2 = Trivia(question: "Which device do you carry in your pocket all day?", answer: "iPhone", guess1: "iPad", guess2: "MacBook", guess3: "iMac")
let trivia3 = Trivia(question: "Who was the Prime Minister of the UK in 1984?", answer: "Margaret Thatcher", guess1: "David Cameron", guess2: "Tony Blair", guess3: "Winston Churchill")
let trivia4 = Trivia(question: "Who was the first woman President or Prime Minister in the world?", answer: "Sirivamo Bandaranaike", guess1: "Margaret Thatcher", guess2: "Isabel Peron", guess3: "Ku-baba")

let allQuestionsAndAnswers = [trivia1, trivia2, trivia3, trivia4]