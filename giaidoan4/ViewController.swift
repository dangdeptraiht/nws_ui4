//
//  ViewController.swift
//  giaidoan4
//
//  Created by Dang Nguyen on 15/8/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var timerDisplay: UILabel!
    
    var timer: Timer?
    
    var isTimerRunning = false
    
    var totalTime = 25 * 60
    var currentTime = 25 * 60
    
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCircularTimer()
        updateTimerLabel()
        startButton.addTarget(self,action: #selector(startTime), for: .touchUpInside)
        resetButton.addTarget(self,action: #selector(resetTime), for: .touchUpInside)
    }
    

    func configureCircularTimer() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 1

        view.layer.addSublayer(shapeLayer)
    }
    
    @objc func startTime(){
        if(!isTimerRunning){
            runTime()
        }
    }
    @objc func resetTime(){
        isTimerRunning = false
        timer?.invalidate()
        shapeLayer.strokeEnd = 1
        currentTime = totalTime
        updateTimerLabel()
        updateCircularTimer()
    }
    func runTime(){
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil,repeats: true)
        isTimerRunning = false
    }
    @objc func updateTimer(){
            currentTime -= 1
            updateTimerLabel()
            updateCircularTimer()
    }
    
    func updateTimerLabel() {
        let minutes = currentTime / 60
        let seconds = currentTime % 60
        timerDisplay.text = String(format: "%02d:%02d", minutes, seconds)        
       
    }

    func updateCircularTimer() {
        let percentage = CGFloat(currentTime) / CGFloat(totalTime)
        shapeLayer.strokeEnd = percentage
        print("Stroke End: \(percentage)")
    }



}

