//
//  ViewController.swift
//  Quiz_Animation
//
//  Created by 이정민 on 2022/09/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }

    //@IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    
    let questions:[String] = ["From what is cognac made?" , "What is 7 + 7?", "What is the capital of Vermont?"]
    let answers:[String] = ["Grapes", "14", "Montepeller"]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject){
        currentQuestionIndex = currentQuestionIndex + 1
        if(currentQuestionIndex == questions.count){
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
        questionLabel.alpha = 0
        animationLabelTransition()
        
    }
    
    @IBAction func showAnswer(sender: AnyObject){
        let answer:String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animationLabelTransition(){
        let animationClouse = { () -> Void in
            self.questionLabel.alpha = 1 // duration동안 최종적으로 도달하는 값
        }
        UIView.animate(withDuration: 2.0, animations: animationClouse)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionLabel.alpha = 0
    }

}

