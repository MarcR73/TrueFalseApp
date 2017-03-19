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
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
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
        removeButtons()
        createButtons()
        playAgainButton.isHidden = true
    }
    
    
    func displayScore() {
     
        // Display play again button
        removeButtons()
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let correctAnswer = currentQuestion.CorrectAnswer()
        
        if correctAnswer == sender.titleLabel?.text {
            correctQuestions += 1
            answerLabel.text = "Correct!"
            sender.backgroundColor = UIColor.green
        } else {
            answerLabel.text = "Sorry, wrong answer!"
        }
        playAgainButton.setTitle("Next question", for: .normal)
        playAgainButton.isHidden = false
    }
    
    @IBAction func nextRound() {
        if questionsAsked == trivia.questions.count {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    

    func playAgain() {
    questionsAsked = 0
    correctQuestions = 0
    displayQuestion()

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
    
    func removeButtons() {
        for locView in self.view.subviews {
            if locView.isKind(of: UIButton.self) {
            
                locView.isHidden = true
            }
        }
    }
    
    func createButtons(){
        let buttonWidth: CGFloat = (self.view.bounds.width - 60)
        var buttonY: CGFloat = self.view.bounds.height / 3.0  // our Starting Offset, could be 0
        let buttonX: CGFloat = (self.view.bounds.width - buttonWidth) / 2.0
        
        let numberOfButtons = CGFloat(currentQuestion.options.count)
        for answer in currentQuestion.options {
            
            let answerButton = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: 50))
            buttonY = buttonY + ((self.view.bounds.height - (self.view.bounds.height / 3.0)) / (numberOfButtons + 1)) // we are going to space these UIButtons 50px apart

            answerButton.layer.cornerRadius = 8  // get some fancy pantsy rounding
            answerButton.backgroundColor = UIColor(red: 55/255.0, green: 118/255.0, blue: 147/255.0, alpha: 1.0)
            answerButton.setTitle("\(answer)", for: .normal) // We are going to use the item name as the Button Title here.
            answerButton.titleLabel?.text = "\(answer)"
            answerButton.addTarget(self, action: #selector(ViewController.checkAnswer(_:)), for: .touchUpInside)
            self.view.addSubview(answerButton)  // myView in this case is the view you want these buttons added
        }
    }
}

