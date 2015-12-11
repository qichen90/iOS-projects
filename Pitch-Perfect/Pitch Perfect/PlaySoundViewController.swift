//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by 陈琪 on 12/9/15.
//  Copyright © 2015 陈琪. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var receivedRecord: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize
        stopButton.hidden = true
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedRecord.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedRecord.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // play sounds fast and slow
    func playSounds(rate: Float){
        stopButton.hidden = false
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func snailPlaySounds(sender: UIButton) {
        playSounds(0.5)
    }
    
    @IBAction func rabbitSounds(sender: UIButton) {
        playSounds(1.5)
    }
    
    // play sounds with vairable pitch
    func playVariablePitch(pitch: Float){
        stopButton.hidden = false
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }

    @IBAction func chipMunkSounds(sender: UIButton) {
        playVariablePitch(1000)
    }
    @IBAction func darthvaderSounds(sender: UIButton) {
        playVariablePitch(-1000)
    }
    
    @IBAction func stopSounds(sender: UIButton) {
        audioPlayer.stop()
        audioPlayerNode.stop()
    }
}
