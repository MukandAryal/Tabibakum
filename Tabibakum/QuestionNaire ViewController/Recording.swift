//
//  Recording.swift
//  Audio Recorder
//
//  Created by Venkat Kukunuru on 30/12/16.
//  Copyright © 2016 Venkat Kukunuru. All rights reserved.
//

import Foundation
import AVFoundation
import QuartzCore

open class Recording : NSObject {
    
    @objc public enum State: Int {
        case none, record, play
    }
    
    static var directory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    
    open var state: State = .none
    
    open var bitRate = 192000
    open var sampleRate = 44100.0
    open var channels = 1
    
    fileprivate let session = AVAudioSession.sharedInstance()
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    fileprivate var link: CADisplayLink?
    
    // MARK: - Initializers
    
    public override init() {
        super.init()
    }
    
    // MARK: - Record
    
    open func prepare() throws {
        let settings: [String: AnyObject] = [
            AVFormatIDKey : NSNumber(value: Int32(kAudioFormatAppleLossless) as Int32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue as AnyObject,
            AVEncoderBitRateKey: bitRate as AnyObject,
            AVNumberOfChannelsKey: channels as AnyObject,
            AVSampleRateKey: sampleRate as AnyObject
        ]
        let audioFilename = getFileURL()
        recorder = try AVAudioRecorder(url: audioFilename, settings: settings)
        recorder?.prepareToRecord()
    }
    
    open func record() throws {
        if recorder == nil {
            try prepare()
        }
        try session.setCategory(AVAudioSession.Category.playAndRecord)
        try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        recorder?.record()
        state = .record
        
    }
    
    // MARK: - Playback
    
    open func play() throws {
        try session.setCategory(AVAudioSession.Category.playback)
        
        player = try AVAudioPlayer(contentsOf: getFileURL())
        
        player?.play()
        state = .play
    }
    open func playSaved() throws {
        try session.setCategory(AVAudioSession.Category.playback)
        preparePlayer()
        player?.play()
        state = .play
    }
    
    open func stop() {
        switch state {
        case .play:
            player?.stop()
            player = nil
        case .record:
            recorder?.stop()
            recorder = nil
            
        default:
            break
        }
        state = .none
    }
    
    func preparePlayer() {
        var error: NSError?
        do {
            player = try AVAudioPlayer(contentsOf: getFileURL() as URL)
        } catch let error1 as NSError {
            error = error1
            player = nil
        }
        
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            
            player?.prepareToPlay()
            player?.volume = 10.0
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileURL() -> URL {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        return path as URL
    }
    
}
