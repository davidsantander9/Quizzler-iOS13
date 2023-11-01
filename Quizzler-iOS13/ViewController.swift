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
        ("Four + Two is equal to Six", true),
        ("Five - Three is greater than One", true),
        ("Three + Eight is less than Ten", false),
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestionUI()
    }

    
    @IBAction func pressedAcctionButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle?.boolValue
        let correctAnswer = quizQuestions[questionNumber].1
        
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
        questionLabel.text = quizQuestions[questionNumber].0
    }
}

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

