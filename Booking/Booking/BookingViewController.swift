//
//  ViewController.swift
//  Booking
//
//  Created by 이정민 on 2022/12/29.
//

import UIKit

class BookingViewController: UIViewController, DatabaseDelegate {

    var userName: String! = "gdhong"
    var userGroup: String! = "TennisCourt"
    var maxSlot: Int = 50
    var maxTotal: Int = 0
    var maxContinuity: Int = 0
    var nowHour: Int = 0
    var nowMinute: Int = 0
    
    //현재 시간을 가져오기 위한 변수들
    var date = Date()
    var cal = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getTime()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if windowScene.interfaceOrientation.isPortrait {
                drawBase_1()
            }
            else {
                drawBase_2()
            }
                    
        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        getTime()
        if UIDevice.current.orientation.isPortrait {
            //세로모드
            for view in self.view.subviews{
                view.removeFromSuperview()
            }
            drawBase_1()
        }else {
            //가로모드
            for view in self.view.subviews{
                view.removeFromSuperview()
            }
            drawBase_2()
        }
    }


    //세로모드
    func drawBase_1(){
        
        let baseStackView: UIStackView = {
            let baseStackView = UIStackView()
            
            baseStackView.translatesAutoresizingMaskIntoConstraints = false
            baseStackView.axis = .vertical
            baseStackView.alignment = .fill
            baseStackView.distribution = .fillEqually
            baseStackView.spacing = 1
            return baseStackView
        }()
        
        view.addSubview(baseStackView)
        baseStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        baseStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        baseStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        
        for i in 0..<25 {
            let outerStackView = UIStackView()
            outerStackView.translatesAutoresizingMaskIntoConstraints = false
            outerStackView.axis = .horizontal
            outerStackView.alignment = .fill
            outerStackView.distribution = .fillEqually
            outerStackView.spacing = 4
            
            baseStackView.addArrangedSubview(outerStackView)
            
            for j in 0..<2 {
                let innerStackView = UIStackView()
                innerStackView.axis = .horizontal
                //innerStackView.alignment = .fill
                innerStackView.distribution = .fill
                //innerStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                innerStackView.spacing = 1
                innerStackView.translatesAutoresizingMaskIntoConstraints = false
                
                outerStackView.addArrangedSubview(innerStackView)
                
                let hour = i
                let minute = j*30
                let t_text = String(format: "%02d : %02d", hour, minute)
                
                let leftLabel = UILabel()
                leftLabel.textAlignment = .center
                leftLabel.layer.borderWidth = 2
                leftLabel.textAlignment = .center
                leftLabel.text = t_text
                leftLabel.translatesAutoresizingMaskIntoConstraints = false
                leftLabel.layer.borderColor = UIColor.black.cgColor
                innerStackView.addArrangedSubview(leftLabel)
                leftLabel.widthAnchor.constraint(equalTo: innerStackView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
                
                let rightLabel = UILabel()
                rightLabel.textAlignment = .center
                rightLabel.layer.borderWidth = 2
                rightLabel.translatesAutoresizingMaskIntoConstraints = false
                rightLabel.layer.borderColor = UIColor.black.cgColor
                innerStackView.addArrangedSubview(rightLabel)
                
                if hour*60+minute <= nowHour*60+nowMinute {
                    leftLabel.backgroundColor = UIColor.gray
                    rightLabel.backgroundColor = UIColor.gray
                    continue
                }
                
                let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(tryBooking))
                innerStackView.addGestureRecognizer(tapGestureRecognizer);
            }
        }
    }
    
    //가로모드
    func drawBase_2(){
        let baseStackView: UIStackView = {
            let baseStackView = UIStackView()
            
            baseStackView.translatesAutoresizingMaskIntoConstraints = false
            baseStackView.axis = .vertical
            baseStackView.alignment = .fill
            baseStackView.distribution = .fillEqually
            baseStackView.spacing = 1
            return baseStackView
        }()
        
        view.addSubview(baseStackView)
        baseStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        baseStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        baseStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        for i in 0 ..< 13 {
            let outerStackView = UIStackView()
            outerStackView.translatesAutoresizingMaskIntoConstraints = false
            outerStackView.axis = .horizontal
            outerStackView.alignment = .fill
            outerStackView.distribution = .fillEqually
            outerStackView.spacing = 4
            
            baseStackView.addArrangedSubview(outerStackView)
            
            for j in 0..<4 {
                
                let innerStackView = UIStackView()
                innerStackView.axis = .horizontal
                //innerStackView.alignment = .fill
                innerStackView.distribution = .fill
                //innerStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                innerStackView.spacing = 1
                innerStackView.translatesAutoresizingMaskIntoConstraints = false
                innerStackView.isUserInteractionEnabled = true
                
                outerStackView.addArrangedSubview(innerStackView)
                
                let hour = (i*120 + j*30)/60
                let minute = j*30%60
                
                if(hour>24){
                    continue
                }
                
                let t_text = String(format: "%02d : %02d", hour, minute)
                
                let leftLabel = UILabel()
                innerStackView.addArrangedSubview(leftLabel)
                leftLabel.layer.borderWidth = 2
                leftLabel.textAlignment = .center
                //timeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                leftLabel.translatesAutoresizingMaskIntoConstraints = false
                leftLabel.widthAnchor.constraint(equalTo: innerStackView.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
                leftLabel.text = t_text
                
                
                let rightLabel = UILabel()
                innerStackView.addArrangedSubview(rightLabel)
                rightLabel.textAlignment = .center
                rightLabel.layer.borderWidth = 2
                //nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                rightLabel.translatesAutoresizingMaskIntoConstraints = false
                //stackView에 View추가
                
                if hour*60+minute <= nowHour*60+nowMinute {
                    leftLabel.backgroundColor = UIColor.gray
                    rightLabel.backgroundColor = UIColor.gray
                    continue
                }
                
                let tapGestureRecognier = UITapGestureRecognizer(target: self, action: #selector(tryBooking))
                innerStackView.addGestureRecognizer(tapGestureRecognier)
            }
        }
    }

    @objc func tryBooking(gesture: UITapGestureRecognizer){
        let innerView = gesture.view as! UIStackView
        let label = (innerView.arrangedSubviews[1] as! UILabel)
        if let text = label.text, text.isEmpty {
            label.text = "예약완료"
        }
        else{
            label.text = ""
        }
    }

    func getTime(){
        nowHour = cal.component(.hour, from: date)
        nowMinute = cal.component(.minute, from: date)
        print(nowHour)
    }
    
}

