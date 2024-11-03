//
//  TimerTechTaskViewController.swift
//  TechTask1
//
//  Created by Vladimir Vinakheras on 30.10.2024.
//

import Foundation
import UIKit
import Lottie
import SnapKit

public class TimerTechTaskViewController: UIViewController {
   //MARK: Literals
    private var initialTimerValue = "00:00:00"
    private var labelFontName = "SFProDisplay-Semibold"
    private var animationName = "vibratingBox3D"
    private var backgroundColor = "#F5F5F5"
   
    //MARK: UI Elements
    private var backgroundView = UIView()
    private var animationView = AnimationView()
    private var circleView = UIView()
    private var timerLabel = UILabel()
    private var countdownTimer: Timer?
    private var remainingTime : TimeInterval = 1560
    
    //MARK: Functions
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCircleView()
        setupAnimationView()
        setupTimerLabel()
        setupUI()
        setupConstraints()
    }
    
    private func setupAnimationView() {
        animationView = AnimationView(name: animationName )
        animationView.frame = CGRect(x: 0, y: 0, width: 106, height: 107)
        animationView.center = CGPoint(x: view.center.x, y: view.center.y)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
    }
    
     private func setupCircleView() {
         circleView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
         circleView.layer.cornerRadius = 84
         circleView.layer.borderWidth = 1.91
         circleView.layer.borderColor = UIColor.white.cgColor
     }
    
    private func setupTimerLabel() {
        timerLabel = UILabel()
        timerLabel.textAlignment = .center
    }
    
    private func setupUI(){
        for subView in [circleView, animationView, timerLabel] {
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        animationView.play()
        startCountdown()
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
       
        circleView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(safeArea)
            make.height.equalTo(168)
            make.width.equalTo(168)
        }

        animationView.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.top)
            make.centerX.equalTo(safeArea)
            make.height.equalTo(106)
            make.width.equalTo(106)
        }

        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(animationView.snp.bottom).offset(6) 
            make.height.equalTo(23)
            make.width.equalTo(100)
        }
        
    }

    
    private func startCountdown() {
        updateTimerLabel()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            countdownTimer?.invalidate()
            remainingTime = 1560
            startCountdown()
        }
    }
    
    private func updateTimerLabel() {
        let textToShow = remainingTime.formattedTimeForTimerTask()
        guard let labelFont = UIFont(name: labelFontName, size: 22) else {return}
            let attributedText = NSAttributedString(
                string: textToShow,
                attributes: [
                    .strokeColor: UIColor.black,
                    .foregroundColor: UIColor.white,
                    .strokeWidth: -4.0,
                    .font: labelFont
                    
                ]
            )
            
            timerLabel.attributedText = attributedText
        }
    
    deinit {
        countdownTimer?.invalidate()
    }
}
