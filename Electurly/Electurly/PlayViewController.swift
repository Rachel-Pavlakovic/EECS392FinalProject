//
//  PlayViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic on 5/2/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController, AVAudioPlayerDelegate {
    
    var urlArray = [URL]()
    var currentCell = String()
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playAudio(_ sender: UIButton) {
        do {
            let url = URL(string: currentCell)
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
}
