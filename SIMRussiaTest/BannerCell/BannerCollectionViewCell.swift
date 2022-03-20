//
//  BannerCollectionViewCell.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 19.03.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    
    static let reuseId = "bannerCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(imageName: String) {
        mainImage.contentMode = .scaleAspectFit
        mainImage.image = UIImage(named: imageName)?.resized(toWidth: 1435)
    }
}
