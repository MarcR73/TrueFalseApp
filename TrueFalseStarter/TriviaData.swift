//
//  TriviaData.swift
//  TrueFalseStarter
//
//  Created by Marc Roelofs on 16/03/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

struct QuestionProvider {
    var question: String
    var options: [String]
    var correctAnswer: Int
    
    func CorrectAnswer() -> String {
        return options[correctAnswer-1]
    }
    
}

class QuestionsCollection {
    
    var usedQuestions: [Int] = []
    
    
    let questions: [QuestionProvider] = [QuestionProvider(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"], correctAnswer: 2),
                                          QuestionProvider(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], correctAnswer: 1),
                                          QuestionProvider(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], correctAnswer: 3),
                                          QuestionProvider(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], correctAnswer: 3),
                                          QuestionProvider(question: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], correctAnswer: 4),
                                          QuestionProvider(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argentina", "Spain"], correctAnswer: 2),
                                          QuestionProvider(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], correctAnswer: 2),
                                          QuestionProvider(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], correctAnswer: 1),
 //                                         QuestionProvider(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], correctAnswer: 1),
        QuestionProvider(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden"], correctAnswer: 1),
                                          QuestionProvider(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France", "Germany", "Japan", "Great Brittain"], correctAnswer: 4)
    ]
    
    
    func nextQuestion() -> QuestionProvider {

        var indexOfSelectedQuestion: Int = GKRandomSource.sharedRandom().nextInt(upperBound: self.questions.count)
        //Generate Randomnumber, check "usedQuestions" if is already used
        //if yes, generate another one, else return the question for index [randomNumber]
        if usedQuestions.contains(indexOfSelectedQuestion) {
            while usedQuestions.contains(indexOfSelectedQuestion) {
                indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: self.questions.count)
            }
        }
        // store final index to check later if already used
        usedQuestions.append(indexOfSelectedQuestion)
        return questions[indexOfSelectedQuestion]
        
    }
    
}




