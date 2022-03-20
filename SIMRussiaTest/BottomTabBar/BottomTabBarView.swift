//
//  BottomTabBarView.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 20.03.2022.
//

import Foundation
import UIKit

@IBDesignable
final class BottomTabBarView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var showcaseImageView: UIImageView!
    @IBOutlet weak var showcaseLabel: UILabel!
    
    var isFavouriteScreen: Bool = false
    var bottomBarDelegate: BottomTabBarDelegate?
    
    func setupView() {
        guard let view = self.loadViewFromNib(nibName: "BottomTabBarView") else { return }
        view.frame = self.bounds
        addSubview(view)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setScreen(isFavourite: Bool) {
        if isFavourite {
            favouriteLabel.textColor = UIColor(red: 0.886, green: 0.106, blue: 0.145, alpha: 1)
            favouriteImageView.image = UIImage(named: "favouriteIcon")
            
            showcaseLabel.textColor = UIColor(red: 0.067, green: 0.133, blue: 0.2, alpha: 1)
            showcaseImageView.image = UIImage(named: "showcaseIcon")
        } else {
            showcaseLabel.textColor = UIColor(red: 0.886, green: 0.106, blue: 0.145, alpha: 1)
            showcaseImageView.image = UIImage(named: "selectShowCase")
            
            favouriteLabel.textColor = UIColor(red: 0.067, green: 0.133, blue: 0.2, alpha: 1)
            favouriteImageView.image = UIImage(named: "tabBarFavourite")
        }
        self.isFavouriteScreen = isFavourite
    }
    
    @IBAction func onTapFavouriteButton(_ sender: Any) {
        if !isFavouriteScreen {
            bottomBarDelegate?.onTapFavourite()
        }
    }
    
    @IBAction func onTapShowcaseButton(_ sender: Any) {
        if isFavouriteScreen {
            bottomBarDelegate?.onTapShowcase()
        }
    }
}
