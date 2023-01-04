//
//  ViewController.swift
//  Booking
//
//  Created by 이정민 on 2022/12/29.
//

import UIKit

class BookingViewController: UIViewController {

    var userName: String! = "gdhong"
    var userGroup: String! = "TennisCourt"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //세로버전
        
        let baseStackView: UIStackView = {
            let baseStackView = UIStackView()
            
            baseStackView.translatesAutoresizingMaskIntoConstraints = false
            baseStackView.axis = .horizontal
            baseStackView.alignment = .fill
            baseStackView.distribution = .fillEqually
            baseStackView.spacing = 8
            baseStackView.backgroundColor = UIColor.gray
            return baseStackView
        }()
        
        view.addSubview(baseStackView)
        baseStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        baseStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        baseStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        
        let outerStackView = UIStackView()
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .vertical
        outerStackView.alignment = .fill
        outerStackView.distribution = .fillEqually
        outerStackView.spacing = 8
        outerStackView.backgroundColor = UIColor.gray
        
        baseStackView.addArrangedSubview(outerStackView)
        
        for i in 0..<10 {
            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            //innerStackView.alignment = .fill
            innerStackView.distribution = .fillEqually
            //innerStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            innerStackView.spacing = 4
            innerStackView.translatesAutoresizingMaskIntoConstraints = false
            innerStackView.backgroundColor = UIColor.cyan
            
            outerStackView.addArrangedSubview(innerStackView)
            
            let leftLabel = UILabel()
            leftLabel.layer.borderWidth = 2
            //timeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            leftLabel.layer.borderColor = UIColor.black.cgColor
            
            let rightLabel = UILabel()
            rightLabel.layer.borderWidth = 2
            //nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            rightLabel.layer.borderColor = UIColor.black.cgColor
            //stackView에 View추가
            innerStackView.addArrangedSubview(leftLabel)
            innerStackView.addArrangedSubview(rightLabel)
        }
        
    }

    //세로모드
    func drawBase_1(){
        
    }
    
    //가로모드
    func drawBase_2(){
        
    }

}

