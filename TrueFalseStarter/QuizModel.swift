//
//  ModelQuiz.swift
//  TrueFalseStarter
//
//  Created by Gary Luce on 01/07/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct QuestionsAndAnswers {

    let trivia: [[String : String]] = [
        ["Question": "Who was the CEO of Apple in 1978?", "One": "Steve Jobs", "Two": "Jean-Louis Gasse", "Answer" : "Michael Scott", "Three" : "Tim Cook"],
        ["Question" : "Which device do you carry in your pocket all day?", "Answer": "iPhone", "One": "iPad", "Two" : "MacBook", "Three" : "iMac"],
        ["Question" : "Who was the Prime Minister of the UK in 1984?", "One": "David Cameron", "Answer": "Margaret Thatcher", "Two" : "Tony Blair", "Three" : "Winston Churchill"],
        ["Question" : "Who was the first woman President or Prime Minister in the world?", "One": "Margaret Thatcher", "Two": "Isabel Peron", "Three" : "Ku-baba", "Answer" : "Sirivamo Bandaranaike"]
        ]
    
    
}

struct Trivia {
    let question: String
    let answer: String
    let guess1: String
    let guess2: String
    let guess3: String
}

let trivia1 = Trivia(question: "Who was the CEO of Apple in 1978?", answer: "Michael Scott", guess1: "Steve Jobs", guess2: "Jean-Louis Gasse", guess3: "Tim Cook")
let trivia2 = Trivia(question: "Which device do you carry in your pocket all day?", answer: "iPhone", guess1: "iPad", guess2: "MacBook", guess3: "iMac")
let trivia3 = Trivia(question: "Who was the Prime Minister of the UK in 1984?", answer: "Margaret Thatcher", guess1: "David Cameron", guess2: "Tony Blair", guess3: "Winston Churchill")
let trivia4 = Trivia(question: "Who was the first woman President or Prime Minister in the world?", answer: "Sirivamo Bandaranaike", guess1: "Margaret Thatcher", guess2: "Isabel Peron", guess3: "Ku-baba")