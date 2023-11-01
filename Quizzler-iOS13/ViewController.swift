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
        Question(text: "Four + Two is equal to Six", answer: true),
        Question(text: "Five - Three is greater than One", answer:  true),
        Question(text: "Three + Eight is less than Ten", answer:  false),
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

