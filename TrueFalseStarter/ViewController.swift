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
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        firstButton.layer.cornerRadius = 8
        secondButton.layer.cornerRadius = 8
        thirdButton.layer.cornerRadius = 8
        fourthButton.layer.cornerRadius = 8
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Changed so the data of the new trivia struct is used
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        switch questionDictionary.options.count {
        case 1:
            firstButton.isHidden = false
            firstButton.setTitle(questionDictionary.options[0], for: .normal)
            secondButton.isHidden = true
            thirdButton.isHidden = true
            fourthButton.isHidden = true
        case 2:
            firstButton.isHidden = false
            firstButton.setTitle(questionDictionary.options[0], for: .normal)
            secondButton.isHidden = false
            secondButton.setTitle(questionDictionary.options[1], for: .normal)
            thirdButton.isHidden = true
            fourthButton.isHidden = true
        case 3:
            firstButton.isHidden = false
            firstButton.setTitle(questionDictionary.options[0], for: .normal)
            secondButton.isHidden = false
            secondButton.setTitle(questionDictionary.options[1], for: .normal)
            thirdButton.isHidden = false
            thirdButton.setTitle(questionDictionary.options[2], for: .normal)
            fourthButton.isHidden = true
        case 4:
            firstButton.isHidden = false
            firstButton.setTitle(questionDictionary.options[0], for: .normal)
            secondButton.isHidden = false
            secondButton.setTitle(questionDictionary.options[1], for: .normal)
            thirdButton.isHidden = false
            thirdButton.setTitle(questionDictionary.options[2], for: .normal)
            fourthButton.isHidden = false
            fourthButton.setTitle(questionDictionary.options[3], for: .normal)
        default:
            firstButton.isHidden = false
            firstButton.setTitle(questionDictionary.options[0], for: .normal)
            secondButton.isHidden = true
            thirdButton.isHidden = true
            fourthButton.isHidden = true
        }
        playAgainButton.isHidden = true
    }
    
    
    func displayScore() {
        // Hide the answer buttons
        firstButton.isHidden = true
        secondButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.CorrectAnswer()
        
        if (sender === firstButton &&  correctAnswer == "True") || (sender === secondButton && correctAnswer == "False") {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
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
        firstButton.isHidden = false
        secondButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

