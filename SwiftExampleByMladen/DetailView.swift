//
//  DetailView.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 13. 2. 2023..
//

import UIKit
import Network
import SafariServices

class DetailView: UIViewController {
    
    var licenceUrl : String = ""
    
    @IBOutlet var viewDetail: UIView!
    
    @IBOutlet var topSV: UIStackView!
    
    @IBOutlet var internetLabel: UILabel!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var innerView: UIView!
    
    @IBOutlet var outwardSVSV: UIStackView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var landscapeImage: UIImageView!
    
    @IBOutlet var licenceButton: UIButton!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func licenceButtonPressed(_ sender: Any) {
        
        let url = URL(string: licenceUrl)
        
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
                    self.licenceButton.isEnabled = false
                    self.viewDetail.addMessageAndTag(tag: 676, tabBarRatio: 1)
                    
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.internetLabel.text = "You are online"
                    self.licenceButton.isEnabled = true
                    if let viewWithTag = self.view.viewWithTag(676) {
                        viewWithTag.removeFromSuperview()
                    }
                    
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        backButton.tintColor = Commons.MAIN_COLOR
        
        licenceButton.setRounded()
        licenceButton.addBorderAroundButton(color: Commons.MAIN_COLOR_CG)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        backButton.tintColor = Commons.MAIN_COLOR
        
        licenceButton.setRounded()
        licenceButton.addBorderAroundButton(color: Commons.MAIN_COLOR_CG)
        
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

    
    
}
