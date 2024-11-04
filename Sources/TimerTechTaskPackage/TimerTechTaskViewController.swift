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
   // MARK: - Literals
    private var initialTimerValue = "00:00:00"
    private var labelFontName = "SFProDisplay-Semibold"
    private var animationName = "vibratingBox3D"
    
    // MARK: - UI Elements
    private var backgroundView = UIView()
    private var animationView = AnimationView()
    private var circleView = UIView()
    private var timerLabel = UILabel()
    private var countdownTimer: Timer?
    private var remainingTime: TimeInterval = 1560
    
    // MARK: - Functions
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupBackgroundView()
        setupCircleView()
        setupAnimationView()
        setupTimerLabel()
        setupUI()
        setupConstraints()
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor.clear
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCircleView() {
        circleView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        circleView.layer.borderWidth = 1.91
        circleView.layer.borderColor = UIColor.white.cgColor
        view.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAnimationView() {
        animationView = AnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTimerLabel() {
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        for subView in [backgroundView, circleView, animationView, timerLabel] {
            view.addSubview(subView)
        }
        
        animationView.play()
        startCountdown()
    }
    
    private func setupConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(view.snp.width)
        }
        
        circleView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(backgroundView.snp.width)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.top.equalTo(circleView)
            make.width.height.equalTo(circleView.snp.width).multipliedBy(0.6)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.top.equalTo(animationView.snp.bottom).offset(6)
            make.width.equalTo(circleView.snp.width).multipliedBy(0.6)
            make.height.equalTo(circleView.snp.width).multipliedBy(0.13)
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
        
        let fontSize = circleView.frame.width * 0.13
        let strokeWidth = -circleView.frame.width * 0.03

        guard let labelFont = UIFont(name: labelFontName, size: fontSize) else { return }
        let attributedText = NSAttributedString(
            string: textToShow,
            attributes: [
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .strokeWidth: strokeWidth,
                .font: labelFont
            ]
        )
        
        timerLabel.attributedText = attributedText
    }
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
         
            circleView.layer.cornerRadius = circleView.frame.width / 2
        }
    
    deinit {
        countdownTimer?.invalidate()
    }
}
