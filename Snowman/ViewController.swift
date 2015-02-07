//
//  ViewController.swift
//  Snowman
//
//  Created by challenge on 2/5/15.
//  Copyright (c) 2015 com.thesyedahmed. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import CoreLocation //iBeacon is a part of the CoreLocation frameworking. <syed ahmed>

let uuid = NSUUID(UUIDString: "0CFB85FC-1C8F-468F-8967-443A4F649B2A")

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate { //adding FBLoginViewDelegate
                                                     //adding CLLocationManagerDelegate protocol for view 
                                                     //controller to know which delegate methods it will
                                                     //have available <syed ahmed>
   
    
    let region = CLBeaconRegion(proximityUUID: uuid, identifier: "Walker")//defining a region. The UUID I am looking for. Need to add server side programming to
    //collect UUID and Username upon registration
    //var proximityID = NSUUID(UUIDString: "46068cc849f0c68ad9bdd2113818ae2b23999278")
    
    let locationManager = CLLocationManager() //creating an instance of a Core Location Manager <syed ahmed>
    //to use core location framework. locationManager will handle
    //all the details of looking for the beacons and reporting back
    
    let imagePicker = UIImagePickerController()
    //@IBOutlet var fbLoginView : FBLoginView! //creating the outlet
    
    //@IBOutlet weak var crosshair: UIImageView!
    //@IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func loginVerifyButton(sender: AnyObject) {
        
        var usrEntered = usernameTextField.text
        var pwdEntered = passwordTextField.text
        var emlEntered = emailTextField.text
        if usrEntered != "" && pwdEntered != "" && emlEntered != "" {
            // If not empty then yay, do something
        } else {
            self.messageLabel.text = "All Fields Required"
        }
    }
    
    @IBOutlet var alternateSignIn: UIButton!
    
    var array = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnStart.hidden = true
        //self.backgroundImage.hidden = true
        //self.crosshair.hidden = true
        // Loop through all the capture devices on this phone
        //captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        
        self.locationManager.delegate = self //with this locationManager will know that View Controller should be its
                                         //delegate (and messages would be delivered in the view controller
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startRangingBeaconsInRegion(region)
        
        
    }
    
    //takes the location location manager gets. sends to apple servers.
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation (manager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks [0] as CLPlacemark
                self.displayLocationInfo(pm)
            }else{
                println("Error with data")
            }
        })
    }
    
    //printing info from apple servers
    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    //if the location manager finds an error
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
            
        }
    
    /*
    override func viewDidDisappear(animated: Bool) {
        NSLog("view did disappear")
        
        locationManager.stopMonitoringForRegion(region)
    }
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .Authorized, .AuthorizedWhenInUse:
            NSLog("CL Authorization status is now - Authorized")
            
            locationManager.startMonitoringForRegion(region)
            locationManager.startRangingBeaconsInRegion(region)
        case .NotDetermined:
            NSLog("CL Authorization status is now - Not determined")
        case .Restricted, .Denied:
            NSLog("CL Authorization status is now - Restricted")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        NSLog("Did start monitoring for region")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        NSLog("Did enter region!")
    }*/
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println(beacons)
        
    }
    
    /*
    func createOverlayView() -> UIView{
        
        //Initialize the overlay view
        let overlay = UIView()
        //Make it so that the overlay view is transparent
        overlay.opaque = false
        overlay.backgroundColor = UIColor.clearColor()
        //Create an object representing the image of the targeting mechanism
        let crossHair = UIImage(named: "crosshair.png")
        let crossHairView = UIImageView(image: crossHair)
        //Set the frame size of the crosshair view
        crossHairView.frame = CGRectMake(0, 40, 320, 300)
        //Center the crosshair
        crossHairView.contentMode = UIViewContentMode.Center
        //Add the crosshair to the overlay view
        overlay.addSubview(crossHairView)
        
        return overlay
    }
*/
    /*
    @IBAction func btnStartTapped(sender: AnyObject) {
        //TESTING CODE
        /*let url = NSURL(string: "http://imgur.com/bcdARJf.jpg")
        var data = NSData(contentsOfURL: url!)
        
        
        let internetFace = UIImage(data: data!)
        //UIImageWriteToSavedPhotosAlbum(image: internetFace, completionTarget: nil, completionSelector: nil, contextInfo: nil)
        UIImageWriteToSavedPhotosAlbum(internetFace, nil, nil, nil)
        
        
        */
        //END TEST CODE
        
        //let imagePicker = UIImagePickerController()
        /*
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
            let overlay = createOverlayView()
            //Add the overlay view over the camera
            imagePicker.cameraOverlayView = overlay
        }
        else{
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        //Start the camera with the overlay
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        */
        
        
    }
    */
    /*New method using AVCaptureSession*/
    /*
    func openCamera(){
        var error : NSError?
        var session : AVCaptureSession = AVCaptureSession()
        var mainView : UIView = UIView()
        var cameraSession = AVCaptureVideoPreviewLayer(session: session)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            session.sessionPreset = AVCaptureSessionPreset640x480
        }
        else
        {
            session.sessionPreset = AVCaptureSessionPresetPhoto
        }
        //Select a video device make an input
        var device : AVCaptureDevice?
        var desiredPosition = AVCaptureDevicePosition.Back
        //find the back facing camera
        var d : AVCaptureDevice
        var devicesWithMediaType = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        // find the front facing camera
        for d in devicesWithMediaType{
            if (d.position == desiredPosition){
                device = d as AVCaptureDevice
                break
            }
        }
        if ( device == nil){
            device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        }
        //get the input device
        var deviceInput = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error)
        
        if (error == nil){
            if( session.canAddInput(deviceInput as AVCaptureInput)){
                session.addInput(deviceInput as AVCaptureInput)
            }
    
            cameraSession = AVCaptureVideoPreviewLayer(session: session)
            cameraSession.backgroundColor = UIColor.blackColor().CGColor
            cameraSession.videoGravity = AVLayerVideoGravityResizeAspect
            var rootLayer : CALayer =  mainView.layer
            rootLayer.masksToBounds = true
            rootLayer.frame = rootLayer.bounds
            rootLayer.addSublayer(cameraSession)
            session.startRunning()
            mainView.layer.addSublayer(cameraSession)
            
        }
        
        if (error != nil){
            var alertView : UIAlertView = UIAlertView(title: "Failed with error", message: error?.localizedDescription, delegate: nil, cancelButtonTitle: "Dismiss")
            alertView.show()
        }
    }
     */
    /*
    Responsible for face detection.
    @author Towhid Absar <mac9908@rit.edu>
        */
    /*
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary) {
        //picks the image from the picker controller.
        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        backgroundImage.image = photo
        
        //Setup the image.
        var ciImage  = CIImage(image: backgroundImage.image)
        //Setup the FaceDetector
        var ciDetector = CIDetector(ofType:CIDetectorTypeFace
            ,context:nil
            ,options:[
                CIDetectorAccuracy:CIDetectorAccuracyHigh,
                CIDetectorSmile:true ]
            
        )
        self.crosshair.image = UIImage(named: "crosshair.png")
        self.crosshair.opaque = false
        self.crosshair.hidden = false
        
        
        var features = ciDetector.featuresInImage(ciImage)
        let size = backgroundImage.image?.size
        
        UIGraphicsBeginImageContext(size!)
        let img = backgroundImage.image
        img?.drawInRect(CGRectMake(0,0,size!.width,size!.height))
        var hitTarget = false
        
        for feature in features{
            
            //All the variables for detecting the
            
            
            //context
            var drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            var faceRect = (feature as CIFaceFeature).bounds
            
            faceRect.origin.y = size!.height - faceRect.origin.y - faceRect.size.height
            CGContextSetStrokeColorWithColor(drawCtxt, UIColor.redColor().CGColor)
            CGContextStrokeRect(drawCtxt,faceRect)
            
            //mouth
            if(feature.mouthPosition != nil){
                var mouthRectY = size!.height - feature.mouthPosition.y
                var mouthRect  = CGRectMake(feature.mouthPosition.x - 5,mouthRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt,UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,mouthRect)
            }
            
            //hige
            /*var higeImg      = UIImage(named:"crosshair.png")
            var mouseRectY = size!.height - feature.mouthPosition.y
            var higeWidth  = faceRect.size.width * 4/5
            var higeHeight = higeWidth * 0.3
            var higeRect  = CGRectMake(feature.mouthPosition.x - higeWidth/2,mouseRectY - higeHeight/2,higeWidth,higeHeight)
            CGContextDrawImage(drawCtxt,higeRect,higeImg!.CGImage)
            */
            //leftEye
            if(feature.leftEyePosition != nil){
                var leftEyeRectY = size!.height - feature.leftEyePosition.y
                var leftEyeRect  = CGRectMake(feature.leftEyePosition.x - 5,leftEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,leftEyeRect)
            }
            
            //rightEye
            if(feature.rightEyePosition != nil){
                var rightEyeRectY = size!.height - feature.rightEyePosition.y
                var rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5,rightEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,rightEyeRect)
            }
            var faceLength1 = faceRect.origin.x
            var faceLength2 = faceRect.origin.x + faceRect.size.width
            var faceHeight1 = faceRect.origin.y
            var faceHeight2 = faceRect.origin.y - faceRect.size.height
            var crossLength1 = self.crosshair.bounds.origin.x
            var crossLength2 = self.crosshair.bounds.size.width + self.crosshair.bounds.origin.x
            var crossHeight1 = self.crosshair.bounds.origin.y
            var crossHeight2 = self.crosshair.bounds.origin.y - self.crosshair.bounds.size.height
            
            if (faceLength1>crossLength1 && faceLength2<crossLength2 && faceHeight1<crossHeight1 && faceHeight2>crossHeight2)
            {
                hitTarget = true
            }
            
            
        }
        var drawedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(drawedImage, nil, nil, nil)
        
        mainView.addSubview(self.crosshair)
        mainView.addSubview(backgroundImage)
        mainView.bringSubviewToFront(self.crosshair)
        
        if (hitTarget){
        backgroundImage.image = drawedImage
        backgroundImage.hidden = false
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

