//
//  StartView.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 10. 2. 2023..
//

import UIKit
import Network

class StartView: UIViewController {
    
    @IBOutlet var viewStart: UIView!
    
    @IBOutlet var topSV: UIStackView!
    
    @IBOutlet var internetLabel: UILabel!
    
    @IBOutlet var outwardSV: UIStackView!
    
    @IBOutlet var personalImage: UIImageView!
    
    @IBOutlet var introTextLabe: UILabel!
    
    @IBOutlet var enterButton: UIButton!
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        
        print("BUTTON PRESSED", MockData.exampleArray[0]["image"]!)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ImagesView") as! ImagesView
        self.present(viewController, animated:false, completion:nil)
    
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
                    
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.internetLabel.text = "You are online"
                    
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        personalImage.setRounded()
        personalImage.addBorderAroundImage(color: Commons.MAIN_COLOR_CG)
        
        enterButton.titleLabel?.text = "PLEASE ENTER"
        enterButton.setTitle("PLEASE ENTER", for: .normal)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        enterButton.setRounded()
        enterButton.addBorderAroundButton(color: Commons.MAIN_COLOR_CG)
        enterButton.titleLabel?.tintColor = Commons.MAIN_COLOR
        enterButton.titleLabel?.text = "PLEASE ENTER"
        enterButton.setTitle("PLEASE ENTER", for: .normal)
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .light {
            print("Light mode")
            personalImage.image = UIImage(named: "light_mladen225")
            personalImage.contentMode = .scaleAspectFill
            introTextLabe.textColor = .black
            internetLabel.textColor = .black
        } else {
            print("Dark mode")
            personalImage.image = UIImage(named: "dark_mladen225")?.withRenderingMode(.alwaysTemplate)
            personalImage.contentMode = .scaleAspectFill
            introTextLabe.textColor = .white
            internetLabel.textColor = .white
        }
    }


}

