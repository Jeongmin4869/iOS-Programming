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
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let miniStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let timeView = UIView()
        timeView.layer.borderWidth = 5
        timeView.layer.borderColor = UIColor.black.cgColor
        
        let nameView = UIView()
        nameView.layer.borderWidth = 5
        nameView.layer.borderColor = UIColor.black.cgColor
        
        //stackView에 View추가
        miniStackView.addArrangedSubview(timeView)
        miniStackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(miniStackView)
    
    }


}

