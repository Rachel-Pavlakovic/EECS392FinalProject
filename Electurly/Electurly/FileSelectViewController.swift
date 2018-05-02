//
//  FileSelectViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic on 5/1/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit

class FileSelectViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let fileManager = FileManager.default
        let dirPaths = fileManager.urls(for: .documentDirectory,
                                        in: .userDomainMask)
        
        print(dirPaths[0].absoluteString)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var audioArray = [String]()
        var videoArray = [String]()
        
        for url in dirPaths {
            print(url.absoluteString)
            let str_url = url.absoluteString
            if str_url.count > 4 {
                if str_url.suffix(4) == ".caf" {
                    audioArray.append(getFileName(str_url))
                } else if str_url.suffix(4) == ".mp4" {
                    videoArray.append(getFileName(str_url))
                }
            }
        }
        
        for file in audioArray {
            cell.textLabel!.text = file
        }
        for file in videoArray {
            cell.textLabel!.text = file
        }
        
        return cell
    }
    
    func getFileName(_ url : String) -> String {
        var fileName = ""
        for char in url {
            if char != "/" {
                fileName.append(char)
            } else {
                fileName = ""
            }
        }
        return fileName
    }
}
