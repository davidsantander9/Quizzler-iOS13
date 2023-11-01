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
    var questionNumber = 0
    var timePassedToAnswer = 0
    var secondsRemainingToAnswer = 0
    var timePassedToShowFeedback = 0
    var secondsRemainingFeedback = 0
    
    // Constants
    let secondsToAnswer = 30
    let secondsToShowFeedBack = 3
    let quizQuestions = [
        Question(q: "A slug's blood is green.", a: true),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: true),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: true),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: true),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: false),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: true),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: false),
        Question(q: "Google was originally called 'Backrub'.", a: true),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: true),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: false),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: false),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.",a: true)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestionUI()
        secondsRemainingToAnswer = secondsToAnswer
        secondsRemainingFeedback = secondsToShowFeedBack
        startTimerToAnswer()
    }

    
    @IBAction func pressedAcctionButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle?.boolValue
        let correctAnswer = quizQuestions[questionNumber].answer
        
        timePassedToAnswer = 0
        secondsRemainingToAnswer = secondsToAnswer
        
        timePassedToShowFeedback = 0
        secondsRemainingFeedback = secondsToShowFeedBack
        
        startTimerToAnswer()
        startTimerToShowFeedBack()
        
        if userAnswer == correctAnswer {
            sender.backgroundColor = UIColor.green
        } else{
            sender.backgroundColor = UIColor.red
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
        progressBarQuestion.progress = Float(questionNumber + 1) / Float(quizQuestions.count)
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

