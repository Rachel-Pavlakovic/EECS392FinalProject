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
        
        reloadTableViewContent()
    }
    
    func reloadTableViewContent()
    {
        self.tableView.reloadData()
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
        
        //Document directory URL.
        let docDirect = dirPaths[0]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        do {
            
            let fileURLs = try fileManager.contentsOfDirectory(at: docDirect, includingPropertiesForKeys: nil)
 
            var audioArray = [String]()
            var videoArray = [String]()
            
            for url in fileURLs {
                let str_url = url.absoluteString
                
                if str_url.count > 5 {
                    if str_url.suffix(5) == ".caf/" {
                        audioArray.append(getFileName(str_url))
                    } else if str_url.suffix(5) == ".mp4/" {
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
            
            print("LENGTH OF AUDIO ARRAY: " + String(audioArray.count))
            
            
            print("LENGTH OF VIDEO ARRAY: " + String(videoArray.count))

        } catch {
            print("\(error.localizedDescription)")
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
