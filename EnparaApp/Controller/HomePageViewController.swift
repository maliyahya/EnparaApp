//
//  ViewController.swift
//  EnparaApp
//
//  Created by Muhammet Ali Yahyaoğlu on 3.03.2024.
//

import UIKit
import UIKit

class HomePageViewController: UIViewController {
    
    private let karacaImage:UIImageView={
        let imageView=UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints=false
        imageView.image=UIImage(named: "karaca")
        return imageView
    }()
    private let helpButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "figure.wave")
        let imageSize = CGSize(width: 35, height: 25)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        image?.draw(in: CGRect(origin: .zero, size: imageSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        button.setImage(resizedImage, for: .normal)
        button.contentMode = .center
        button.frame = CGRect(x: 170, y: 680, width: 60, height: 60)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.purple.cgColor
        button.tintColor = .purple
        return button
    }()
    private let headerView:UIImageView={
        let imageView=UIImageView()
        imageView.image=UIImage(named: "enpara2")
        imageView.frame=CGRect(x: 100, y: 80, width: 200, height: 50)
        return imageView
    }()
    private let bottomLabel:UILabel={
       let label=UILabel()
        label.text="Çözüm                  Merkezi"
        label.textColor = .purple
        label.font = .systemFont(ofSize: 20)
        
        label.frame=CGRect(x: 95, y: 700, width: 250, height: 20)
        return label
    }()
    private let loginButton:UIButton={
        let circleButton = UIButton(type: .system)
        circleButton.frame = CGRect(x: 135, y: 325, width: 130, height: 130)
        circleButton.layer.cornerRadius = 0.5 * circleButton.bounds.size.width
        circleButton.backgroundColor = UIColor.purple
        circleButton.setImage(UIImage(systemName: "power"), for: .normal)
        circleButton.tintColor = .white
        circleButton.setTitle("Cep Şube Giriş", for: .normal)
        circleButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        circleButton.titleLabel?.numberOfLines=2
        circleButton.titleLabel?.textAlignment = .center
        circleButton.imageEdgeInsets=UIEdgeInsets(top: 0, left: 50, bottom: 50, right: 0)
        circleButton.titleEdgeInsets=UIEdgeInsets(top: 25, left: -25, bottom: 0, right: 0)
        circleButton.setTitleColor(UIColor.white, for: .normal)
        circleButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return circleButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let circleView = CircleView(frame: CGRect(x: -3, y: 200, width: 400, height: 400))
        circleView.backgroundColor = UIColor.clear
        view.addSubview(headerView)
        view.addSubview(circleView)
        view.addSubview(helpButton)
        view.addSubview(loginButton)
        view.addSubview(bottomLabel)
        view.backgroundColor = .systemBackground
    }
    
    @objc private func didTapLogin(){
        let vc = LoginPageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
    
    
  
