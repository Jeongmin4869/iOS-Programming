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
        currentQuestionLabel.text = questions[currentQuestionIndex]
        nextQuestionLabelCenterXConstraint.constant = -view.frame.width
    }

    //@IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    let questions:[String] = ["From what is cognac made?" , "What is 7 + 7?", "What is the capital of Vermont?"]
    let answers:[String] = ["Grapes", "14", "Montepeller"]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject){
        currentQuestionIndex = currentQuestionIndex + 1
        if(currentQuestionIndex == questions.count){
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        //questionLabel.alpha = 0
        animationLabelTransition()
        
    }
    
    @IBAction func showAnswer(sender: AnyObject){
        let answer:String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animationLabelTransition(){
        /*
        let animationClouse = { () -> Void in
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1 // duration동안 최종적으로 도달하는 값
        }
         */
        UIView.animate(withDuration: 2.0, delay: 0, options: [],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        self.nextQuestionLabelCenterXConstraint.constant = 0
                        self.currentQuestionLabelCenterXConstraint.constant = self.view.frame.width
                        self.view.layoutIfNeeded() // 변경된 Constraint를 적용시킨다.
                        },
                       completion: {_ in
                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                        self.nextQuestionLabelCenterXConstraint.constant = -self.view.frame.width
                        //self.updateOffScreenLabel()
                        }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }

}

