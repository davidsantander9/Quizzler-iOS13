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
    let secondsToAnswer = 30
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
        let isCorrect = quizLogic.checkAnswer(answer: userAnswer!)
        
        timePassedToAnswer = 0
        secondsRemainingToAnswer = secondsToAnswer
        
        timePassedToShowFeedback = 0
        secondsRemainingFeedback = secondsToShowFeedBack
        
        startTimerToAnswer()
        startTimerToShowFeedBack()
        
        sender.backgroundColor = isCorrect ? UIColor.green : UIColor.red
        
        quizLogic.moveToNextQuestion()
        
        updateQuestionUI()
    }
    
    func updateQuestionUI(){
        questionLabel.text = quizLogic.getQuestionText()
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
               countdownTimerToAnswer?.invalidate()
               //timerLabel.text = "Done"
               //playSound(fileName: "alarm_sound")
           }
    }

}

extension String {
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

