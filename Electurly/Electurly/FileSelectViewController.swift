//
//  FileSelectViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic on 5/1/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit

class FileSelectViewController: UITableViewController {
    
    var audioArray = [URL]()
    var videoArray = [URL]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager.default
        let directoryPaths = fileManager.urls(for: .documentDirectory,
                                        in: .userDomainMask)
        let docDirect = directoryPaths[0]
        let index = docDirect.absoluteString.count - 10
        let location = docDirect.absoluteString.prefix(index)
        let url = NSURL(string: String(location))
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at:url! as URL, includingPropertiesForKeys: nil)
            // process files
            populateNameArrays(fileURLs, docDirect)
            print(fileURLs.count)
            print(audioArray.count)
        } catch {
            print("Error while enumerating files \(docDirect.path): \(error.localizedDescription)")
        }
        
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
        return audioArray.count + videoArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateNameArrays(_ fileURLs: [URL], _ docDirect: URL) {
        for url in fileURLs {
            let str_url = url.absoluteString
            
            if str_url.count > 5 {
                /*
                if str_url.suffix(5) == ".caf/" {
                    audioArray.append(getFileName(str_url))
                } else if str_url.suffix(5) == ".mp4/" {
                    videoArray.append(getFileName(str_url))
                }
                */
                
                audioArray = fileURLs.filter{$0.pathExtension == "caf" }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        for file in audioArray {
            cell.textLabel!.text = file.absoluteString
        }
        for file in videoArray {
            cell.textLabel!.text = file.absoluteString
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
