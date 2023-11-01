//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by David C Santander on 01/11/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question{
    let text: String
    let answer: Bool
    
    init(q: String, a: Bool) {
        self.text = q
        self.answer = a
    }
}
