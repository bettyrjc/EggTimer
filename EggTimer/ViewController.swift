//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTime = [
        "Soft": 3,
        "Medium": 4,
        "Hard":7
    ]
    var totaTime = 0
    var player: AVAudioPlayer!
    var secondsPassed = 0
    let timer = Timer()

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleText: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        titleText.text = sender.currentTitle!
        progressBar.progress = 0.0
        secondsPassed = 0
        
        let hardness = sender.currentTitle!
        totaTime = eggTime[hardness]!
      
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatedTimer), userInfo:nil , repeats: true)
  
    }
   @objc func updatedTimer(){
       if(secondsPassed < totaTime){
           secondsPassed += 1
           let percentageProgress = Float(secondsPassed) / Float(totaTime)
           progressBar.progress = Float(percentageProgress)
          
       }
       else{
           timer.invalidate()
           titleText.text = "DONE!"
           
           let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
           player = try! AVAudioPlayer(contentsOf: url!)
           player.play()
       }
    }
}
