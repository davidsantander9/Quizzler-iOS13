//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBarr: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    // Variables
    var questionNumber = 0
    
    
    // Constants
    let quizQuestions = [
        Question(q: "A slug's blood is green.", a: true),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: true),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: true),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: true),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: true),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: true),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: true),
        Question(q: "Google was originally called 'Backrub'.", a: true),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: true),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: true),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: true),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", true)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestionUI()
    }

    
    @IBAction func pressedAcctionButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle?.boolValue
        let correctAnswer = quizQuestions[questionNumber].answer
        
        if userAnswer == correctAnswer {
            print("Rigth")
        } else{
            print("Wrong")
        }
        
        if questionNumber < quizQuestions.count - 1   {
            questionNumber += 1
            updateQuestionUI()
        } else {
            questionNumber = 0
        }
    }
    
    func updateQuestionUI(){
        questionLabel.text = quizQuestions[questionNumber].text
    }
}

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

