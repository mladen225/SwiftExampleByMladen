//
//  ClassExtensions.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 10. 2. 2023..
//

import UIKit
import Foundation
import MapKit

extension UIButton {
    func setRounded() {
        let radius = self.frame.size.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func addBorderAroundButton(color: CGColor) {
    let border = CALayer()
    border.borderColor = color
    border.borderWidth = 2
    let radius = self.frame.size.height / 2
    border.cornerRadius = radius
    border.frame = CGRect(x: 0.0,
                          y: 0.0,
                          width: self.frame.size.width - 0,
                          height: self.frame.size.height + 0)
    self.layer.insertSublayer(border, at: 0)
    }
}

extension UIImageView {
    func setRounded() {
        let radius = self.frame.size.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func addBorderAroundImage(color: CGColor) {
        let border = CALayer()
        border.borderColor = color
        border.borderWidth = 2
        let radius = self.frame.size.height / 2
        border.cornerRadius = radius
        border.frame = CGRect(x: 0.0,
                              y: 0.0,
                              width: self.frame.size.width - 0,
                              height: self.frame.size.height + 0)
        self.layer.insertSublayer(border, at: 0)
    }
}

extension UILabel {
    func addSystemImage(imageName: String, labelText: String) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName:imageName)?.withRenderingMode(.alwaysTemplate)
        let imageOffsetY: CGFloat = -4.0 
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " " + labelText)
        completeText.append(textAfterIcon)
        self.attributedText = completeText
        
    }
}

extension UIView {
    
    func addMessageAndTag(tag: Int, tabBarRatio: CGFloat) {
        
        var noInternetView = UIView()
        
        noInternetView = UIView(frame: CGRect(x: 0, y: 52, width: self.frame.size.width, height: self.frame.size.height - tabBarRatio * 52))
        noInternetView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        noInternetView.layer.zPosition = 2
        noInternetView.tag = tag
        self.addSubview(noInternetView)
        
        var noInternetLabel = UILabel()

        noInternetLabel = UILabel(frame: CGRect(x: 20, y: (self.frame.size.height / 2) - (self.frame.size.width / 2), width: self.frame.size.width - 40, height: self.frame.size.width - 40))
        noInternetLabel.textColor = Commons.MAIN_COLOR
        noInternetLabel.textAlignment = .center
        noInternetLabel.numberOfLines = 10
        noInternetLabel.backgroundColor = UIColor.white
        noInternetLabel.layer.cornerRadius = 24
        noInternetLabel.layer.borderColor = Commons.MAIN_COLOR_CG
        noInternetLabel.layer.borderWidth = 2
        noInternetLabel.layer.masksToBounds = true
        noInternetLabel.text = "You are off line\n\nYou need to be online in order to have functionality on this screen.\n\nThis function works only on real devices properly."
        noInternetView.addSubview(noInternetLabel)
        
    }
    
}

extension MKMapView {
    
    func centerToLocation(
       _ location: CLLocation,
       regionRadius: CLLocationDistance = 1000
     ) {
       let coordinateRegion = MKCoordinateRegion(
         center: location.coordinate,
         latitudinalMeters: regionRadius,
         longitudinalMeters: regionRadius)
       setRegion(coordinateRegion, animated: true)
     }
}
