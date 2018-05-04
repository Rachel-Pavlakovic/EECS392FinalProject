//
//  SaveVideoViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic and Jack LaRue on 5/2/18.
//  Copyright © 2018 Rachel Pavlakovic and Jack LaRue. All rights reserved.
//

import UIKit

class SaveVideoViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vidnametorecordsegue" {
            let controller = segue.destination as! VideoViewController
            
            if textInput.hasText {
                controller.vidName = textInput.text
            } else {
                let date = Date()
                let calender = Calendar.current
                let day = calender.component(.day, from: date)
                let month = calender.component(.month, from: date)
                let year = calender.component(.year, from: date)
                controller.vidName = String(month) + "_" + String(day) + "_" + String(year)
            }
        }
    }
}
