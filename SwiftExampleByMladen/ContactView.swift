//
//  ContactView.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 13. 2. 2023..
//

import UIKit
import Network
import MapKit
import MessageUI
import SafariServices

class ContactView: UIViewController, UITabBarDelegate, MFMailComposeViewControllerDelegate {
    
    let initialLocation = CLLocation(latitude: 43.848963, longitude: 18.390811)
    var noInternetView = UIView()
    var noInternetLabel = UILabel()
    
    @IBOutlet var contactView: UIView!
    
    @IBOutlet var topSV: UIStackView!
    
    @IBOutlet var leaveAppButton: UIButton!
    
    @IBOutlet var internetLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var phoneButton: UIButton!
    
    @IBOutlet var mailButton: UIButton!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var tabBar: UITabBar!
    
    @IBAction func leaveAppButtonPressed(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dataPresentingViewController = storyBoard.instantiateViewController(withIdentifier: "StartView") as? StartView
        self.present(dataPresentingViewController!, animated: false, completion: nil)
        
    }
    
    @IBAction func phoneButtonPressed(_ sender: Any) {
        
        dialNumber(number: "+38762574998")
        
    }
    
    @IBAction func mailButtonPressed(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self

            composeVC.setToRecipients(["mladen225@gmail.com"])
            composeVC.setSubject("Message Subject")
            composeVC.setMessageBody("", isHTML: false)
            composeVC.modalPresentationStyle = .fullScreen

            self.present(composeVC, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Mail services", message: "Mail services are not available.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func dialNumber(number: String) {
        
        guard let url = URL(string: "telprompt://\(number)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                DispatchQueue.main.async {
                    
                    self.internetLabel.text = "You are offline"
                    self.contactView.addMessageAndTag(tag: 576, tabBarRatio: 2)
                    
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.internetLabel.text = "You are online"
                    
                    if let viewWithTag = self.view.viewWithTag(576) {
                        viewWithTag.removeFromSuperview()
                    }
                    
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        locationLabel.addSystemImage(imageName: "location.fill", labelText: "B. Mutevelica 31")
        locationLabel.textAlignment = .left
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textColor = Commons.MAIN_COLOR
        
        phoneButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        mailButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        mapView.centerToLocation(initialLocation)
        
        let region = MKCoordinateRegion(
          center: initialLocation.coordinate,
          latitudinalMeters: 3000,
          longitudinalMeters: 3000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        let artwork = Artwork(
          title: "My Home",
          locationName: "B. Mutevelica 31",
          discipline: "Residential Building",
          coordinate: CLLocationCoordinate2D(latitude: 43.848963, longitude: 18.390811))
        mapView.addAnnotation(artwork)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        mapView.isUserInteractionEnabled = true
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        traitCollectionDidChange(.current)
        
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items![1]
        tabBar.tintColor = Commons.MAIN_COLOR
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .light {
            print("Light mode")
            
            internetLabel.textColor = .black
            
        } else {
            print("Dark mode")
            
            internetLabel.textColor = .white

        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch (item.tag){
        case 1:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ImagesView") as! ImagesView
            self.present(viewController, animated:false, completion:nil)
            break
        case 2:

            break
        default:
            break
        }
    }
    
    @objc func mapViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let url = URL(string: "https://www.google.com/maps/place/Behd%C5%BEeta+Muteveli%C4%87a,+Sarajevo+71000/@43.8489824,18.3897064,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c91a313b780b:0x897d49b11ad71222!8m2!3d43.8489824!4d18.3897064!16s%2Fg%2F1hjh2xck6")
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
        
    }
    
}

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D

    init(
        title: String?,
        locationName: String?,
        discipline: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String? {
        return locationName
    }
}
