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
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = UIColor.gray
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //세로버전
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        
        let miniStackView = UIStackView()
        miniStackView.axis = .horizontal
        miniStackView.distribution = .fillEqually
        miniStackView.alignment = .fill
        miniStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        miniStackView.spacing = 4
        miniStackView.translatesAutoresizingMaskIntoConstraints = false
        miniStackView.backgroundColor = UIColor.cyan
        
        let timeView = UIView()
        timeView.layer.borderWidth = 2
        //timeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.layer.borderColor = UIColor.black.cgColor
        
        let nameView = UIView()
        nameView.layer.borderWidth = 2
        //nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.layer.borderColor = UIColor.black.cgColor
        //stackView에 View추가
        miniStackView.addArrangedSubview(timeView)
        miniStackView.addArrangedSubview(nameView)
        
        stackView.addArrangedSubview(miniStackView)
        stackView.addArrangedSubview(miniStackView)
        stackView.addArrangedSubview(miniStackView)
    }


}

