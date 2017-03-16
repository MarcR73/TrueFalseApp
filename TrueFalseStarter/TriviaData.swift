//
//  TriviaData.swift
//  TrueFalseStarter
//
//  Created by Marc Roelofs on 16/03/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//


struct TriviaProvider {
    var question: String
    var options: [String]
    var correctAnswer: Int
    
    func CorrectAnswer() -> String {
        return options[correctAnswer-1]
    }
}


let trivia: [TriviaProvider] = [TriviaProvider(question: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"], correctAnswer: 2),
                                        TriviaProvider(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], correctAnswer: 1),
                                        TriviaProvider(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], correctAnswer: 3),
                                        TriviaProvider(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], correctAnswer: 3),
                                        TriviaProvider(question: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], correctAnswer: 4),
                                        TriviaProvider(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argentina", "Spain"], correctAnswer: 2),
                                        TriviaProvider(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], correctAnswer: 2),
                                        TriviaProvider(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], correctAnswer: 1),
                                        TriviaProvider(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], correctAnswer: 1),
                                        TriviaProvider(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France", "Germany", "Japan", "Great Brittain"], correctAnswer: 4)
    ]



