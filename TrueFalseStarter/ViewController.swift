//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var indexBlacklist = [Int]()
    
    var gameSound: SystemSoundID = 0
    
    let questionsAndAnswers = QuestionsAndAnswers()
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!

    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBAction func answerButtonPressed(sender: UIButton) {

        if sender.titleLabel?.text == questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"] {
            commentLabel.text = "You have the right answer!"
            correctAnswerSound()
            playCorrectAnswerSound()
            // In order to display the correct answer, we have to check it is not nil, else it will display a wrapped optional.
        } else if (questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"] != nil) {
            commentLabel.text = "You are wrong! The correct answer was \(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"]!)"
            incorrectAnswerSound()
            playIncorrectAnswerSound()
        }
    }
  
    @IBAction func nextQuestion(sender: AnyObject) {
        displayQuestion()
        displayAnswers()
        setCommentLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        setCommentLabel()
        displayAnswers()
    }
    
    func setCommentLabel() {
        commentLabel.text = "Ready?"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsAndAnswers.trivia.count)
        if indexBlacklist.contains(indexOfSelectedQuestion) {
            displayQuestion()
        } else {
    //    we add the index to the blacklist, so this question isn't shown again during the current game
        indexBlacklist.append(indexOfSelectedQuestion)
        print("Blacklist... \(indexBlacklist)")
            print("Answers \(questionsAndAnswers.trivia[0].values)")
        let questionDictionary = questionsAndAnswers.trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary["Question"]

        }
    }

    
    func displayAnswers() {
        answer1Button.setTitle(questionsAndAnswers.trivia[indexOfSelectedQuestion]["One"], forState: .Normal)
        answer2Button.setTitle(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Two"], forState: .Normal)
        answer3Button.setTitle(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"], forState: .Normal)
        answer4Button.setTitle(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Three"], forState: .Normal)
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        // Display play again button
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
//        let selectedQuestionDict = questionsAndAnswers.trivia[indexOfSelectedQuestion]
//        let correctAnswer = selectedQuestionDict["Answer"]
//        
//        if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
//            correctQuestions += 1
//            questionField.text = "Correct!"
//        } else {
//            questionField.text = "Sorry, wrong answer!"
//        }
//        
//        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
//        trueButton.hidden = false
//        falseButton.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        indexBlacklist = []
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func correctAnswerSound() {
        self.gameSound = 0
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("applause2", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func incorrectAnswerSound() {
        self.gameSound = 0
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("boooo", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playIncorrectAnswerSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

