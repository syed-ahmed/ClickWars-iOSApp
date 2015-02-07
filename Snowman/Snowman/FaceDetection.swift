//
//  FaceDetection.swift
//  Snowman
//
//  Created by challenge on 2/7/15.
//  Copyright (c) 2015 com.thesyedahmed. All rights reserved.
//

import Foundation
import UIKit

class FaceDetection: UIView {
    
    var borderLayer : CAShapeLayer?
    var corners : [CGPoint]?
    var btnCapture : UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setMyView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawBorder(points : [CGPoint]) {
        self.corners = points
        //let path = UIBezierPath(rect: points)
        let path = UIBezierPath()
        println(points)
        path.moveToPoint(points.first!)
        for (var i = 1; i < points.count; i++) {
            path.addLineToPoint(points[i])
        }
        
        path.addLineToPoint(points.first!)
        borderLayer?.path = path.CGPath
        let crossHair = UIImage(named: "crosshair.png")
        let crossHairView = UIImageView(image: crossHair)
        crossHairView.opaque = false
        self.addSubview(crossHairView)
        crossHairView.center = self.center
        
    }
    
    func setMyView() {
        borderLayer = CAShapeLayer()
        borderLayer?.strokeColor = UIColor.redColor().CGColor
        borderLayer?.lineWidth = 2.0
        borderLayer?.fillColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(borderLayer)
        
    }
    
}