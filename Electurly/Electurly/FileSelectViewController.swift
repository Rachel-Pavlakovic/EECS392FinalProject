//
//  FileSelectViewController.swift
//  Electurly
//
//  Created by Rachel Pavlakovic on 5/1/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit

class FileSelectViewController: UITableViewController {
    
    var urlArray = [URL]()
    var label = String()
    
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
        } catch {
            print("Error while enumerating files \(docDirect.path): \(error.localizedDescription)")
        }
        
        reloadTableViewContent()
    }
    
    func reloadTableViewContent() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateNameArrays(_ fileURLs: [URL], _ docDirect: URL) {
        for url in fileURLs {
            let str_url = url.absoluteString
            
            if str_url.count > 5 {
                urlArray = fileURLs.filter{$0.pathExtension == "caf" || $0.pathExtension == "mp4"}
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let url = urlArray[indexPath.row]
        cell.textLabel!.text = getFileName(url.absoluteString)
        
        return cell
    }
    
    func getFileName(_ url : String) -> String {
        var name = ""
        
        for char in url {
            if char == "/" {
                name = ""
            } else {
                name.append(char)
            }
        }
        return name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.label = urlArray[indexPath.row].absoluteString
        }
        if segue.identifier == "playAudio" {
            let controller = segue.destination as! PlayViewController
            controller.urlArray = self.urlArray
            controller.currentCell = label
        }
    }
}
