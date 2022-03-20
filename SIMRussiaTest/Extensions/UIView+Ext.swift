//
//  UIView+Ext.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 18.03.2022.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension UICollectionView {
    func reloadDataWithConstraints() {
        self.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIDevice {
    class func deviceType()->DeviceType{
        return DeviceType()
    }

    public enum DeviceType {
        case IphonePlus, IphoneSE, Iphone8, IphoneX, IphoneXsMax
        
        init () {
            
            if screenWidth == 320 {
                self = .IphoneSE
            }
            else if screenWidth == 375 && screenWidth < 700 {
                self = .Iphone8
            }
            else if screenWidth == 375 && screenWidth > 700 {
                self = .IphoneX
            }
            else if screenWidth == 414 && screenWidth < 800 {
                self = .IphonePlus
            }
            else {
                self = .IphoneXsMax
            }
        }
    }
}
