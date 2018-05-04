//
//  VideoViewController.swift
//  Electurly
//
//
//
//  Created with help from the code at this URL:
//  https://stackoverflow.com/questions/41697568/capturing-video-with-avfoundation
//
//  Created by Rachel Pavlakovic on 5/1/18.
//  Copyright © 2018 Rachel Pavlakovic. All rights reserved.
//

import UIKit
import AVFoundation

class VideoViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {

    @IBOutlet weak var cameraView: UIView!
    
    let button = UIView()
    
    let session = AVCaptureSession()
    let output = AVCaptureMovieFileOutput()
    let fixedOrientation = AVCaptureVideoOrientation.portrait
    var layer : AVCaptureVideoPreviewLayer!
    var currInput : AVCaptureDeviceInput!
    var vidURL : URL!
    var vidName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prepares the video URL.
        let fileManager = FileManager.default
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        vidURL = dirPaths[0].appendingPathExtension(vidName! + ".mp4")
        
        print(vidURL.absoluteString)
        
        if setupRecordingSession() == true {
            preparePreview()
            update_session_status(1)
        }
        
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //Prepares the recording button.
        button.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(VideoViewController.beginRecording))
        button.addGestureRecognizer(recognizer)
        button.backgroundColor = UIColor.blue
        button.frame = CGRect(x: screenWidth/2 - 35, y: screenHeight - 150, width: 50, height: 50)
        cameraView.addSubview(button)
    }
    
    //Prepares the layer in which the video will be recorded.
    func preparePreview() -> Void {
        
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = cameraView.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraView.layer.addSublayer(layer)
        
    }
    
    //Prepares the camera and microphone for recording.
    func setupRecordingSession() -> Bool {
        session.sessionPreset = AVCaptureSession.Preset.high
        
        let cam = AVCaptureDevice.default(for: AVMediaType.video)
        let mic = AVCaptureDevice.default(for: AVMediaType.audio)
        
        if (!setupCamera(cam) || !setupMicrophone(mic)) {
            return false
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        return true
    }
    
    //Sets up the camera for use in recording.
    func setupCamera(_ camera: AVCaptureDevice?) -> Bool {
        
        do {
            
            //Adds camera input to the current session, if possible.
            
            guard let camera = camera else {return false}
            
            let cam = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(cam) {
                session.addInput(cam)
                currInput = cam
            }
            
            return true
            
        } catch {
            //Fails to set up camera.
            return false
        }
    }
    
    //Sets up the microphone for use in recording
    func setupMicrophone(_ mic: AVCaptureDevice?) -> Bool {
        
        do {
            
            //Adds input to the
            
            guard let mic = mic else {return false}
            
            let microphone = try AVCaptureDeviceInput(device: mic)
            if session.canAddInput(microphone) {
                session.addInput(microphone)
            }
            
            return true
            
        } catch {
            //Fails to set up microphone.
            return false
        }
    }
    
    /*
     Updates the session status from running to not running,
     depending on input.
     
     1 = Start running
     0 = End recording.
    */
    func update_session_status(_ flag: Int) -> Void {
        
        let dQueue = DispatchQueue.main
        
        //Begin camera session.
        if (session.isRunning == false && flag == 1) {
            dQueue.async {
                self.session.startRunning()
            }
        }
        //End camera session.
        else if (session.isRunning && flag == 0) {
            dQueue.async {
                self.session.stopRunning()
            }
        }
        
    }
    
    //Begins recording video.
    @objc func beginRecording() -> Void {
        
        if (!output.isRecording) {
            
            let connection = output.connection(with: AVMediaType.video)

            
            //This code will reach the startRecording function if a connection is found.
            //Since we are not attached to an iPhone, this will not record anything.
            guard let activeConn = connection?.isActive else {
                
                let alert = UIAlertController(title: "Camera Not Found", message: "Could not connect to a camera.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
                
                return
                
            }
            
            if activeConn {
                //Begins a recording session.
                output.startRecording(to: vidURL, recordingDelegate: self)
            }
            
        } else {
            finishRecording()
        }
        
    }
    
    //Finishes the recording session, if one is currently in session.
    func finishRecording() -> Void {
        if output.isRecording {
            output.stopRecording()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if (error != nil) {
            print("\(String(describing: error?.localizedDescription))")
        }
        else {
            _ = vidURL as URL
        }
        
        vidURL = nil
    
    }
}
