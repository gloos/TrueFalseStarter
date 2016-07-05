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
    
    var indexOfSelectedQuestion: Int = 0
    var indexBlacklist = [Int]()
    
    var gameSound: SystemSoundID = 0
    
    let questionsAndAnswers = QuestionsAndAnswers()
    var timer = NSTimer()
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!

    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    var counter = 15
    
    @IBAction func answerButtonPressed(sender: UIButton) {

        if sender.titleLabel?.text == questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"] {
            commentLabel.text = "You have the right answer!"
            correctAnswerSound()
            playCorrectAnswerSound()
            stopTimer()
            // In order to display the correct answer (Option number 3), we have to check it is not nil, else it will display a wrapped optional.
        } else if (questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"] != nil) {
            commentLabel.text = "You are wrong! The correct answer was \(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"]!)"
            incorrectAnswerSound()
            playIncorrectAnswerSound()
            stopTimer()
        }
    }
  
    @IBAction func nextQuestion(sender: AnyObject) {
        displayQuestion()
        displayAnswers()
        setCommentLabel()
        startTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
        setCommentLabel()
        displayAnswers()
        startTimer()
    }


    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsAndAnswers.trivia.count)
        //In order to display a question only once, we add the index of the current question to a black list
        if indexBlacklist.contains(indexOfSelectedQuestion) {
            displayQuestion()
        } else {
        indexBlacklist.append(indexOfSelectedQuestion)
        print("Blacklist... \(indexBlacklist)")
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
    
    // MARK: Timer methods
    // Option number 2
    func startTimer() {
        self.counter = 15
        timerLabel.text = String(self.counter)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        if self.counter > 0 {
            timerLabel.text = String(self.counter--)
        } else if self.counter == 0 {
            timerLabel.text = String(0)
            commentLabel.text = "You ran out of time! The correct answer was \(questionsAndAnswers.trivia[indexOfSelectedQuestion]["Answer"]!)"
            stopTimer()
            incorrectAnswerSound()
            playIncorrectAnswerSound()
            
        }
    }
    
    func stopTimer() {
        self.timer.invalidate()
    }
    
    // MARK: Helper methods
    
    
    func setCommentLabel() {
        commentLabel.text = "Ready?"
    }
    
    // MARK: Sounds
    

    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    // Optional number 1
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

