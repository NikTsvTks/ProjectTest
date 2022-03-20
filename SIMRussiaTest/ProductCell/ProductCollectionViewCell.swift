//
//  ProductCollectionViewCell.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 18.03.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var colorProductLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var mainButton: UIButton!
    
    static let reuseId = "productCollectionViewCell"
    var favouriteButtonAction : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
        colorView.layer.cornerRadius = 4
        self.mainButton.addTarget(self, action: #selector(favouriteButtonTapped(_:)), for: .touchUpInside)
    }

    // настройки ячейки
    func setupCell() {
        setupProductLabel(name: "НОЖНИЦЫ ПРЯМЫЕ")
        setupNameLabel(name: "Katachi 5,5 K0655 Basic Cut")
        setupPriceLabel(name: "1 189 ₽")
        setupColorLabel(name: "СТАЛЬНОЙ")
        setupMainButton()
    }
    
    // параметры продукты
    func setupProductLabel(name: String) {
        productLabel.font = UIFont(name: "ProximaNova-Regular", size: 12)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.09
        
        productLabel.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.kern: 0.96, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // параметры названия
    func setupNameLabel(name: String) {
        nameProductLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        nameProductLabel.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // параметры цены
    func setupPriceLabel(name: String) {
        priceProductLabel.font = UIFont(name: "ProximaNova-Regular", size: 18)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.82
        
        priceProductLabel.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // параметры цвета
    func setupColorLabel(name: String) {
        colorProductLabel.font = UIFont(name: "ProximaNova-Regular", size: 10)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        
        colorProductLabel.attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.kern: 0.4, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    // параметры кнопки
    func setupMainButton() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.82

        mainButton.titleLabel?.textColor = .white
        mainButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 12)
        mainButton.titleLabel?.attributedText = NSMutableAttributedString(string: "В КОРЗИНУ", attributes: [NSAttributedString.Key.kern: 0.96, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        mainButton.layer.cornerRadius = 8
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        favouriteButtonAction?()
      }
}
