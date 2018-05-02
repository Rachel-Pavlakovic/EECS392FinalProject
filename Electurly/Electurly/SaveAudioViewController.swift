//
//  SaveAudioViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic on 5/2/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit

class SaveAudioViewController: UIViewController {
    
    @IBOutlet weak var fileName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
