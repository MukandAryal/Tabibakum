//
//  RecorderViewController.swift
//  Audio Recorder
//
//  Created by Venkat Kukunuru on 01/01/17.
//  Copyright © 2017 Venkat Kukunuru. All rights reserved.
//

import Foundation
import UIKit

protocol RecorderViewDelegate : class {
    func didFinishRecording(_ recorderViewController: RecorderViewController)
}

class RecorderViewController: UIViewController {
    open weak var delegate: RecorderViewDelegate?
    var recording: Recording!
    var recordDuration = 0
    var timer = Timer()
     var updater : CADisplayLink! = nil
    var recordSeconds = 0
    var recordMinutes = 0
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
   
    @IBOutlet weak var slider: UISlider!
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRecorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        durationLabel.text = ""
    }
    
    open func createRecorder() {
        
        let img = UIImage(named: "record_audio.png")
        startBtn.setImage(img, for: .normal)
        recording = Recording(to: "recording.m4a")
       slider.isHidden = true
        DispatchQueue.global().async {
            // Background thread
            do {
                try self.recording.prepare()
            } catch {
                print(error)
            }
        }
    }

    open func startRecording() {
        recordDuration = 0
        let img = UIImage(named: "record_stop.png")
        startBtn.setImage(img, for: .normal)
        do {
            try recording.record()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown) , userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }

    open func stop() {
        let img = UIImage(named: "record_audio.png")
        startBtn.setImage(img, for: .normal)
        timer.invalidate()
        slider.isHidden = true
        delegate?.didFinishRecording(self)
        recordDuration = 0
        if updater != nil{
            updater.invalidate()
        }
        recording.stop()
    }
    
    @objc open func countdown() {
        
        durationLabel.text = String( Double(recording.recorder!.currentTime/60).rounded(toPlaces: 2))
        
//        var seconds = "\(recordSeconds)"
//        if recordSeconds < 10 {
//            seconds = "0\(recordSeconds)"
//        }
//        var minutes = "\(recordMinutes)"
//        if recordMinutes < 10 {
//            minutes = "0\(recordMinutes)"
//        }
//        durationLabel.text = "\(minutes):\(seconds)"
//        recordSeconds += 1
//        if recordSeconds == 60 {
//            recordMinutes += 1
//            recordSeconds = 0
//        }
    }
    
    open func startAndStopAc() {
        if recording.state == .record{
           stop()
            let img = UIImage(named: "music_play.png")
            startBtn.setImage(img, for: .normal)
            startBtn.addTargetClosure { _ in
                self.playAc()
                self.updater = CADisplayLink(target: self, selector: #selector(self.updateAudioProgressView))
                self.updater.preferredFramesPerSecond = 1
                self.updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            }
         }
        else{
           startRecording()
        }
    }
  @objc open func updateAudioProgressView()
    {
        if recording.state == .play
        {
            let total = Double(recording.player!.duration/60).rounded(toPlaces: 2)
            let current_time = Double(recording.player!.currentTime/60).rounded(toPlaces: 2)
            slider.minimumValue = 0.0
            slider.maximumValue = Float(recording.player!.duration)
            slider.setValue(Float(recording.player!.currentTime), animated: true)
            durationLabel.text = "\(current_time)/\(total)"
            
        }
    }
   open func playAc() {
        do {
             slider.isHidden = false
            try recording.play()
        } catch {
            print(error)
        }
    }

}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
