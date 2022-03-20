//
//  FavouriteViewController.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 20.03.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var brandButton: UIButton!
    @IBOutlet weak var chapterButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteMainImageView: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var bottomTabBarView: BottomTabBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonStyle()
        setTextStyle()
        setImageStyle()
        bottomTabBarView.setScreen(isFavourite: true)
        bottomTabBarView.bottomBarDelegate = self
        // Do any additional setup after loading the view.
    }
    
    func setImageStyle() {
        let deviceType = UIDevice.deviceType()
        
        switch deviceType {
        case .IphonePlus:
            favouriteMainImageView.image = UIImage(named: "BigMocupIphone")
        case .IphoneSE:
            favouriteMainImageView.image = UIImage(named: "smallMocupIphone")
        case .Iphone8:
            favouriteMainImageView.image = UIImage(named: "smallMocupIphone")
        case .IphoneX:
            favouriteMainImageView.image = UIImage(named: "BigMocupIphone")
        case .IphoneXsMax:
            favouriteMainImageView.image = UIImage(named: "BigMocupIphone")
        }
    }
    
    func setButtonStyle() {
        productButton.layer.cornerRadius = 4
        brandButton.layer.cornerRadius = 4
        chapterButton.layer.cornerRadius = 4
        
        mainButton.layer.cornerRadius = 8
    }
    
    func setTextStyle() {
        descriptionLabel.font = UIFont(name: "ProximaNova-Regular", size: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19

        descriptionLabel.attributedText = NSMutableAttributedString(string: "Добавляйте товары в избранное, чтобы вернуться к ним позже", attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    @IBAction func onTapShowcase(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension FavouriteViewController: BottomTabBarDelegate {
    func onTapFavourite() {
        
    }
    
    func onTapShowcase() {
        dismiss(animated: false, completion: nil)
    }
}
