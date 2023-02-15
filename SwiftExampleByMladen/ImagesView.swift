//
//  ImagesView.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 12. 2. 2023..
//

import UIKit
import Network

class ImagesView: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    @IBOutlet var imagesView: UIView!
    
    @IBOutlet var topSV: UIStackView!
    
    @IBOutlet var leaveAppButton: UIButton!
    
    @IBOutlet var internetLabel: UILabel!
    
    @IBOutlet var outwardSV: UIStackView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var tabBar: UITabBar!
    
    @IBAction func leaveAppButtonPressed(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dataPresentingViewController = storyBoard.instantiateViewController(withIdentifier: "StartView") as? StartView
        self.present(dataPresentingViewController!, animated: false, completion: nil)
        
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500

        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items![0]
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

            break
        case 2:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ContactView") as! ContactView
            self.present(viewController, animated:false, completion:nil)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.exampleArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstImagesCell") as! CustomImagesCell
        
        let article = MockData.exampleArray[indexPath.row]
        let title = article["title"] ?? ""
        let imageName = article["image"]!
        
        print("IMAGE", imageName)
        
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.titleLabel.text = title
        cell.titleLabel.textColor = Commons.MAIN_COLOR
        let image : UIImage = UIImage(named: imageName)!
        cell.landscapeImage.image = image
        
        let tapGestureRecognizerCellButton = UITapGestureRecognizer(target: self, action: #selector(cellImageTapped(tapGestureRecognizer:)))
        tapGestureRecognizerCellButton.numberOfTapsRequired = 1
        cell.landscapeImage.isUserInteractionEnabled = true
        cell.landscapeImage.tag = indexPath.row
        cell.landscapeImage.addGestureRecognizer(tapGestureRecognizerCellButton)
        
        return cell
    }
    
    @objc func cellImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileImage = tapGestureRecognizer.view as! UIImageView
        
        let content = MockData.exampleArray[profileImage.tag]
        
        let title = content["title"]
        let description = content["text"]
        let image = content["image"] ?? ""
        let licenceUrl = content["licenceUrl"] ?? ""
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dataPresentingViewController = storyBoard.instantiateViewController(withIdentifier: "DetailView") as? DetailView
        self.present(dataPresentingViewController!, animated: true, completion: nil)
        
        dataPresentingViewController!.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        dataPresentingViewController!.titleLabel.text = title
        dataPresentingViewController!.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        dataPresentingViewController!.descriptionLabel.text = description
        dataPresentingViewController!.landscapeImage.image = UIImage(named: image)!
        dataPresentingViewController!.licenceUrl = licenceUrl
        dataPresentingViewController!.licenceButton.titleLabel?.tintColor = Commons.MAIN_COLOR
        dataPresentingViewController!.licenceButton.setTitle("Go to Licence page", for: .normal)
    
    }
    
}
    
    

