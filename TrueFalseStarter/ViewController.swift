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
    let trivia = QuestionsCollection()
    var currentQuestion = QuestionProvider(question: "", options: [], correctAnswer: 0)

    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load all sounds
        loadGameStartSound()
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
        // Start game
        playGameStartSound()
        displayQuestion()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Changed so the data of the new trivia struct is used
    func displayQuestion() {
        // Make each button nice slightly rounded
        
        //Remove previous buttons
       
        
        playAgainButton.layer.cornerRadius = 8
        
        currentQuestion = trivia.nextQuestion()
        questionField.text = currentQuestion.question
        createButtons()
    
    }
    
    
    func displayScore() {
     
        // Display play again button
        playAgainButton.isHidden = false
        playAgainButton.setTitle("Play Again", for: .normal)
        
        // Give a different message when score is lower than 6
        switch correctQuestions {
        case 1...5:questionField.text = "You have to try harder!\nYou only got \(correctQuestions) out of \(trivia.questions.count) correct!"
        case 6...10:questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(trivia.questions.count) correct!"
        default:questionField.text = "That is strange, an incorrect number of questions are correct! Did you hack the system?"
        }
        
        
        // Hide all answer buttons
        answerButton1.isHidden = true
        answerButton2.isHidden = true
        answerButton3.isHidden = true
        answerButton4.isHidden = true
        answerLabel.isHidden = true
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = currentQuestion.CorrectAnswer()
        
        //check if clicked button contains the correct answer
        if correctAnswer == sender.titleLabel?.text {
            correctQuestions += 1
            answerLabel.text = "Correct!"
            answerLabel.textColor = UIColor(red: 55/255.0, green: 118/255.0, blue: 147/255.0, alpha: 1.0)
            playCorrectAnswerSound()
        } else {
            answerLabel.text = "Sorry, wrong answer!"
            answerLabel.textColor = UIColor.orange
            playWrongAnswerSound()
        }
        
        //disable all buttons and make gray, so it is not possible to change the answer
        answerButton1.setTitleColor(UIColor.gray, for: .normal)
        answerButton1.isEnabled = false
        answerButton2.setTitleColor(UIColor.gray, for: .normal)
        answerButton2.isEnabled = false
        answerButton3.setTitleColor(UIColor.gray, for: .normal)
        answerButton3.isEnabled = false
        answerButton4.setTitleColor(UIColor.gray, for: .normal)
        answerButton4.isEnabled = false
    
        // Show correct answer in green
        switch currentQuestion.correctAnswer {
        case 1: answerButton1.setTitleColor(UIColor(red: 0, green: 200/255.0, blue: 35/255.0, alpha: 1.0), for: .normal)
        case 2: answerButton2.setTitleColor(UIColor(red: 0, green: 200/255.0, blue: 35/255.0, alpha: 1.0), for: .normal)
        case 3: answerButton3.setTitleColor(UIColor(red: 0, green: 200/255.0, blue: 35/255.0, alpha: 1.0), for: .normal)
        case 4: answerButton4.setTitleColor(UIColor(red: 0, green: 200/255.0, blue: 35/255.0, alpha: 1.0), for: .normal)
        default: break
        }
        //set correct button to normal white color to highlight clicked button
        sender.setTitleColor(UIColor.white, for: .normal)
        answerLabel.isHidden = false
        
        //show button for next question
        playAgainButton.setTitle("Next question", for: .normal)
        playAgainButton.isHidden = false
        
    }
    
    
    @IBAction func nextRound(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Play Again" {
            playAgain()
        }
        else if questionsAsked == trivia.questions.count {
                // Game is over
                displayScore()
            } else {
                // Continue game
                displayQuestion()
            }
    
        
    }
    

    func playAgain() {
        
        //Set scores to 0 and display the first question
        questionsAsked = 0
        correctQuestions = 0
        trivia.usedQuestions.removeAll() //reset array of used random questions
        displayQuestion()

    }
    

    
    // MARK: Helper Methods
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func loadCorrectAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "woow", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctAnswerSound)
    }

    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "buzzer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    
    
    /// Fill buttons with possible answers of current question
    func createButtons() {
        
        //set default settings for 1st button
        answerButton1.setTitle(currentQuestion.options[0], for: .normal)
        answerButton1.layer.cornerRadius = 8
        answerButton1.isEnabled = true
        answerButton1.isHidden = false
        answerButton1.setTitleColor(UIColor.white, for: .normal)
        
        //set default settings for 2nd button
        answerButton2.setTitle(currentQuestion.options[1], for: .normal)
        answerButton2.layer.cornerRadius = 8
        answerButton2.isEnabled = true
        answerButton2.isHidden = false
        answerButton2.setTitleColor(UIColor.white, for: .normal)
        
        //set default settings for 3rd button
        answerButton3.setTitle(currentQuestion.options[2], for: .normal)
        answerButton3.layer.cornerRadius = 8
        answerButton3.isEnabled = true
        answerButton3.isHidden = false
        answerButton3.setTitleColor(UIColor.white, for: .normal)
        
        //set default settings for 4th button
        answerButton4.setTitle(currentQuestion.options[3], for: .normal)
        answerButton4.layer.cornerRadius = 8
        answerButton4.isEnabled = true
        answerButton4.isHidden = false
        answerButton4.setTitleColor(UIColor.white, for: .normal)
        
        answerLabel.isHidden = true
        playAgainButton.isHidden = true
    }
    
}

