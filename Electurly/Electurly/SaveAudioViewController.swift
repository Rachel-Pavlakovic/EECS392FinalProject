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
    
}
