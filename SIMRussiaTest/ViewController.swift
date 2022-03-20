//
//  ViewController.swift
//  SIMRussiaTest
//
//  Created by Никита Цветков on 18.03.2022.
//

import UIKit
protocol BottomTabBarDelegate {
    func onTapFavourite()
    func onTapShowcase()
}

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    // вью для верхнего контента
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    // основной скролл
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: mainView.bounds.width, height: 600))
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // баннер
    private lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // заголовок
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Колорист с нуля"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.white
        label.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return label
    }()
    
    // описание
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Начинай красить и выигрывай!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.white
        label.font = UIFont(name: "ProximaNova-Regular", size: 16)
        return label
    }()
    
    // кнопка в баннере
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_right"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1058823529, blue: 0.1450980392, alpha: 1)
        button.layer.cornerRadius = 28
        return  button
    }()
    
    // коллекция с товарами
    private lazy var productCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 200), collectionViewLayout: layout)
        return collection
    }()
    
    // скролл для баннера
    private lazy var bannerScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 451))
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // сраницы для скрола
    private lazy var bannerPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .red
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.layer.cornerRadius = 2
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var bottomTabBarView: BottomTabBarView = {
        let bottomTabBar = BottomTabBarView()
        bottomTabBar.backgroundColor = .green
        return bottomTabBar
    }()

    // высота коллекции
    private var heightProductsCollectionView: CGFloat {
        let count = 4
        let numberOfLines = (CGFloat(count) / 2).rounded(.up)
        return ((405 + 10) * numberOfLines + 1) - 10
    }
    
    let bannerImages: [String] = ["mainImage", "secondImage"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        bannerScrollView.delegate = self

        bannerPageControl.numberOfPages = bannerImages.count
        bannerPageControl.currentPage = 0
        
        setupProductCollectionView()
        setupConstraint()
        setImageView()
        setHeightCollectionView()
        setupScreens()
        bottomTabBarView.setScreen(isFavourite: false)
        bottomTabBarView.bottomBarDelegate = self
    }

    // настройки для коллекции с товарами
    func setupProductCollectionView() {
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.isPagingEnabled = true
        
        productCollectionView.showsHorizontalScrollIndicator = false
        productCollectionView.showsVerticalScrollIndicator = false
        productCollectionView.isScrollEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 15,
                                           bottom: 0,
                                           right: 15)

        layout.scrollDirection = .vertical
        
        productCollectionView.collectionViewLayout = layout
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
    }
    
    // устанавливаем констрейнты
    func setupConstraint() {
        mainView.addSubview(scrollView)
        mainView.addSubview(bottomTabBarView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bannerScrollView)
        contentView.addSubview(mainImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bannerPageControl)
        contentView.addSubview(mainLabel)
        contentView.addSubview(button)
        scrollView.addSubview(productCollectionView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        bottomTabBarView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        bannerScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        bannerPageControl.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -50),
            scrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomTabBarView.topAnchor, constant: -10),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            bannerScrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            bannerScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            bannerScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            bannerScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29),
            
            bannerPageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            bannerPageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            mainImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            mainImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            mainImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -19),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            
            mainLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            productCollectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 40),
            productCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            productCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            productCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),
            
            bottomTabBarView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            bottomTabBarView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            bottomTabBarView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0)
        ])
        
        contentView.heightAnchor.constraint(equalToConstant: 480).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 451).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        button.widthAnchor.constraint(equalToConstant: 56).isActive = true
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        bannerPageControl.heightAnchor.constraint(equalToConstant: 4).isActive = true
        bannerPageControl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bottomTabBarView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        collectionViewHeightConstraint = productCollectionView.heightAnchor.constraint(equalToConstant: productCollectionView.contentSize.height)
        collectionViewHeightConstraint?.isActive = true
    }
    
    // параметры для основного баннера
    func setImageView() {
        mainImage.layer.masksToBounds = true
        mainImage.clipsToBounds = false
        mainImage.contentMode = .scaleAspectFill
        mainImage.image = UIImage(named: "mainImage")
        mainImage.isHidden = true
        mainImage.layer.cornerRadius = 20
        let maskedCorners: CACornerMask = [
            .layerMinXMaxYCorner, //bottom left
            .layerMaxXMaxYCorner // bottom right
        ]
        mainImage.layer.maskedCorners = maskedCorners
    }
    
    func setupScreens() {
        for index in 0..<bannerImages.count {
            // 1.
            contentView.frame.origin.x = bannerScrollView.frame.size.width * CGFloat(index)
            contentView.frame.size = bannerScrollView.frame.size
            
            // 2.
            let imgView = UIImageView(frame: contentView.frame)
            imgView.layer.masksToBounds = true
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.image = UIImage(named: bannerImages[index])

            self.bannerScrollView.addSubview(imgView)
        }
        // 3.
        bannerScrollView.contentSize = CGSize(width: (bannerScrollView.frame.size.width * CGFloat(bannerImages.count)), height: bannerScrollView.frame.size.height)
        bannerScrollView.delegate = self
        
        bannerScrollView.layer.cornerRadius = 20
        let maskedCorners: CACornerMask = [
            .layerMinXMaxYCorner, //bottom left
            .layerMaxXMaxYCorner // bottom right
        ]
        bannerScrollView.layer.maskedCorners = maskedCorners
        bannerScrollView.tag = 1
    }
    
    // устанавливаем высоту коллекции
    func setHeightCollectionView() {
        productCollectionView.reloadDataWithConstraints()
        collectionViewHeightConstraint?.constant = productCollectionView.contentSize.height
        let height = productCollectionView.contentSize.height + contentView.bounds.size.height + 400
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height)
        productCollectionView.layoutIfNeeded()
    }

    func setText(with page: Int) {
        switch page {
        case 0:
            UIView.animate(withDuration: 0.2) {
                self.mainLabel.alpha = 1.0
                self.descriptionLabel.alpha = 1.0
                self.descriptionLabel.text = "Начинай красить и выигрывай!"
                self.mainLabel.text = "Колорист с нуля"
                self.descriptionLabel.textColor = .white
                self.mainLabel.textColor = .white
                self.view.layoutIfNeeded()
            }
        case 1:
            UIView.animate(withDuration: 0.2) {
                self.mainLabel.alpha = 1.0
                self.descriptionLabel.alpha = 1.0

                let paragraphStyle = NSMutableParagraphStyle()

                paragraphStyle.lineHeightMultiple = 1.18
                self.mainLabel.text = "LSB −35%!"
                self.descriptionLabel.attributedText = NSMutableAttributedString(string: "Очень выгодное предложение для всех", attributes: [NSAttributedString.Key.kern: 0.32, NSAttributedString.Key.paragraphStyle: paragraphStyle])

                self.mainLabel.textColor = UIColor(red: 0.067, green: 0.133, blue: 0.2, alpha: 1)
                self.descriptionLabel.textColor = UIColor(red: 0.067, green: 0.133, blue: 0.2, alpha: 1)
                self.view.layoutIfNeeded()
            }
        default:
            return
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView.tag {
        case 1:
            let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
            bannerPageControl.currentPage = Int(pageNumber)
            setText(with: Int(pageNumber))
            bannerPageControl.currentPage = Int(pageNumber)
        default:
            return
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        switch scrollView.tag {
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.mainLabel.alpha = 0.0
                self.descriptionLabel.alpha = 0.0
            }
        default:
            return
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case productCollectionView:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case productCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell
            cell.favouriteButtonAction = { [unowned self] in
                let vc = FavouriteViewController()
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: false)
              }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case productCollectionView:
            return 40
        default:
            return 40
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case productCollectionView:
            return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 16)
        default:
            return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 16)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case productCollectionView:
            let width = (UIScreen.main.bounds.width / 2) - 35
            let height: CGFloat = 405
            print(scrollView.contentSize.height)
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 10, height: 10)
        }
    }
}

extension ViewController: BottomTabBarDelegate {
    func onTapFavourite() {
        let vc = FavouriteViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    func onTapShowcase() {
    
    }
}
