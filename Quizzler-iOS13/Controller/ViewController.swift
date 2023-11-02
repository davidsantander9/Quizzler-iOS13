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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBarr: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBarQuestion: UIProgressView!
    @IBOutlet weak var progressBarAnswerTime: UIProgressView!
    
    // Variables
    var countdownTimerToAnswer: Timer?
    var countdownTimerFeedBackAnswer: Timer?
    var timePassedToAnswer = 0
    var secondsRemainingToAnswer = 0
    var timePassedToShowFeedback = 0
    var secondsRemainingFeedback = 0
    
    var quizLogic = QuizLogic()
    
    // Constants
    let secondsToAnswer = 10
    let secondsToShowFeedBack = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestionUI()
        secondsRemainingToAnswer = secondsToAnswer
        secondsRemainingFeedback = secondsToShowFeedBack
        startTimerToAnswer()
    }

    
    @IBAction func pressedAcctionButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle?.boolValue
        let isAnswerCorrect = quizLogic.checkAnswer(answer: userAnswer!)
        
        timePassedToAnswer = 0
        secondsRemainingToAnswer = secondsToAnswer
        
        timePassedToShowFeedback = 0
        secondsRemainingFeedback = secondsToShowFeedBack
        
        startTimerToAnswer()
        startTimerToShowFeedBack()
        
        if isAnswerCorrect {
            sender.backgroundColor = UIColor.green
            quizLogic.setScore(newScore: quizLogic.getScore() + 1)
        }else{
            sender.backgroundColor = UIColor.red
        }
        
        quizLogic.moveToNextQuestion()
        updateQuestionUI()
        
        if quizLogic.isQuizComplete(){
            quizLogic.setScore(newScore: 0)
            countdownTimerToAnswer?.invalidate()
        }
    }
    
    func updateQuestionUI(){
        questionLabel.text = quizLogic.getQuestionText()
        scoreLabel.text = "Score: " + String(quizLogic.getScore())
        progressBarQuestion.progress = quizLogic.getQuizProgress()
    }
    
    func startTimerToAnswer(){
        countdownTimerToAnswer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in self?.updateTimer()}
    }
    
    func startTimerToShowFeedBack(){
        countdownTimerFeedBackAnswer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in self?.updateTimer2()}
    }
    
    @objc func updateTimer2() {
           // Increment the time passed
           timePassedToShowFeedback += 1
        if timePassedToShowFeedback == secondsRemainingFeedback {
            trueButton.backgroundColor = UIColor.clear
            falseButton.backgroundColor = UIColor.clear
            countdownTimerFeedBackAnswer?.invalidate()
        }
          
    }
    
    @objc func updateTimer() {
           // Increment the time passed
           timePassedToAnswer += 1
           if timePassedToAnswer < secondsRemainingToAnswer {
               progressBarAnswerTime.progress = Float(timePassedToAnswer) / Float(secondsRemainingToAnswer)
           } else {
               timePassedToAnswer = 0
               secondsRemainingToAnswer = secondsToAnswer
               
               countdownTimerToAnswer?.invalidate()
               
               if !quizLogic.isQuizComplete(){
                   quizLogic.moveToNextQuestion()
                   startTimerToAnswer()
                   updateQuestionUI()
               }
           }
    }
    

}

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

