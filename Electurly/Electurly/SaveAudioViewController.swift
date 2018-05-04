//
//  SaveAudioViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic and Jack LaRue on 5/2/18.
//  Copyright © 2018 Rachel Pavlakovic and Jack LaRue. All rights reserved.
//

import UIKit

class SaveAudioViewController: UIViewController {
    
    @IBOutlet weak var fileName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveFile(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transferNameAudio" {
            let controller = segue.destination as! AudioViewController
            if fileName.hasText {
                controller.selectedFileName = fileName.text
            } else {
                let date = Date()
                let calender = Calendar.current
                let day = calender.component(.day, from: date)
                let month = calender.component(.month, from: date)
                let year = calender.component(.year, from: date)
                controller.selectedFileName = String(month) + "_" + String(day) + "_" + String(year)
            }
        }
    }
    
}
