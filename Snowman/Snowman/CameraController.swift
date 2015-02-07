//
//  CameraController.swift
//  Snowman
//
//  Created by challenge on 2/7/15.
//  Copyright (c) 2015 com.thesyedahmed. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class CameraController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, AVCaptureMetadataOutputObjectsDelegate{
    
    
    @IBOutlet var cameraView: UIView!
    
    var captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var  identifiedBorder : FaceDetection?
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loop through all the capture devices on this phone
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        let devices = AVCaptureDevice.devices()
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        println("Capture device found")
                        beginSession()
                    }
                }
            }
        }
        
        
    }
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            }
        }
    }
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var anyTouch = touches.anyObject() as UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var anyTouch = touches.anyObject() as UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    func configureDevice() {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
        
    }
    
    func beginSession() {
        
        configureDevice()
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        var layer1 : CALayer = CALayer()
        layer1.contents = UIImage(named: "crosshair.png:")
        previewLayer?.addSublayer(layer1)
        previewLayer?.frame = self.view.layer.frame
        
        identifiedBorder = FaceDetection(frame: self.view.bounds)
        identifiedBorder?.backgroundColor = UIColor.clearColor()
        identifiedBorder?.hidden = true;
        self.view.addSubview(identifiedBorder!)
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        println(output.availableMetadataObjectTypes)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureSession.startRunning()
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as AVMetadataObject
            let transformed = previewLayer?.transformedMetadataObjectForMetadataObject(metaData) as AVMetadataFaceObject?
            if let unwrapped = transformed {
                identifiedBorder?.frame = unwrapped.bounds
                identifiedBorder?.hidden = false
                let identifiedCorners = self.translatePoints(unwrapped.bounds, fromView: self.view, toView: self.identifiedBorder!)
                identifiedBorder?.drawBorder(identifiedCorners)
                self.identifiedBorder?.hidden = false
                self.startTimer()
                
            }
        }
    }
    func startTimer() {
        if timer?.valid != true {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "removeBorder", userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
    }
    
    func translatePoints(points : CGRect, fromView : UIView, toView: UIView) -> [CGPoint] {
        var translatedPoints : [CGPoint] = []
        var curr = CGPointMake(points.maxX, points.maxY)
        var currFinal = fromView.convertPoint(curr, toView: toView)
        translatedPoints.append(currFinal)
        
        curr = CGPointMake(points.minX, points.minX)
        currFinal = fromView.convertPoint(curr, toView: toView)
        translatedPoints.append(currFinal)
        /*for point in points {
            var dict = point as NSDictionary
            let x = CGFloat((dict.objectForKey("X") as NSNumber).floatValue)
            let y = CGFloat((dict.objectForKey("Y") as NSNumber).floatValue)
            let curr = CGPointMake(x, y)
            let currFinal = fromView.convertPoint(curr, toView: toView)
            translatedPoints.append(currFinal)
        }*/
        return translatedPoints
    }
    
    
}