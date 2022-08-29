//
//  ViewController.swift
//  Quiz
//
//  Created by 이정민 on 2022/08/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLable.text = questions[currentQuestionIndex]
    }

    @IBOutlet var questionLable:UILabel!
    @IBOutlet var answerLable:UILabel!
    
    let questions:[String] = ["From what is cognac made?", "What is 7+7?,"
                                ,"What is the capital of Vermont?"]
    let answers:[String] = ["Grapes", "14", "Montpelier"]
    var currentQuestionIndex:Int = 0
    
    @IBAction func showNextQuest(sender: AnyObject){
        currentQuestionIndex = currentQuestionIndex + 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        questionLable.text = question
        answerLable.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject){
        let answer: String = answers[currentQuestionIndex]
        answerLable.text = answer;
    }

}

