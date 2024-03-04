//
//  CircleView.swift
//  EnparaApp
//
//  Created by Muhammet Ali Yahyaoğlu on 3.03.2024.
//

import UIKit
class CircleView: UIView {
    var buttonTitles:[String]=["Bas biriktir","ATM bulucu","Bildirimler","Karekod","Oranlar   Kurlar","Bizi Tavsiye Edin","Fırsatlar","Ayın Enparalısı"]
    var buttonColors: [UIColor] = [UIColor.red, UIColor.blue,UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red,]
    var buttonTargets:[UIViewController]=[
        EmptyViewController(),EmptyViewController(),EmptyViewController(),EmptyViewController(),EmptyViewController(),EmptyViewController(),EmptyViewController(),EmptyViewController()]
    var buttons: [UIButton] = []
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor?.setFill()
        UIRectFill(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 10
        context.setFillColor(UIColor.systemBackground.cgColor)
        context.setStrokeColor(UIColor.purple.cgColor)
        context.setLineWidth(2.0)
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        context.drawPath(using: .fillStroke)
        for i in 0..<buttonTitles.count {
            let angle = CGFloat(i) * (CGFloat.pi * 2) / CGFloat(8)
            let padding: CGFloat = 10
            let buttonRadius = radius / 4
            let buttonCenterX = center.x + cos(angle) * (radius - padding - buttonRadius)
            let buttonCenterY = center.y + sin(angle) * (radius - padding - buttonRadius)
            let buttonFrame = CGRect(x: buttonCenterX - buttonRadius, y: buttonCenterY - buttonRadius, width: 2 * buttonRadius, height: 2 * buttonRadius)
            let button = UIButton(frame: buttonFrame)
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setImage(UIImage(named: "enpara"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = buttonColors[i]
            button.setTitle("\(buttonTitles[i])", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemBackground
            let desiredImageHeight: CGFloat = 60
            let desiredImageWidth: CGFloat = 60
            let verticalImageInset = (button.frame.size.height - desiredImageHeight) / 2.0
            let horizontalImageInset = (button.frame.size.width - desiredImageWidth) / 2.0
            button.imageEdgeInsets = UIEdgeInsets(top: -25, left: horizontalImageInset, bottom: verticalImageInset, right: horizontalImageInset)
            button.titleEdgeInsets=UIEdgeInsets(top: 60, left: -60, bottom: 10, right: 0)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            button.addGestureRecognizer(panGestureRecognizer)
            button.layer.cornerRadius = buttonRadius
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
    }
    @objc func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender), index < buttonTitles.count else {
            return
        }
        if let rootViewController = self.window?.rootViewController as? UINavigationController {
               rootViewController.pushViewController(buttonTargets[index], animated: true)
           }
        
    }
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let touchPoint = sender.location(in: self)
            let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            var angle = atan2(touchPoint.y - center.y, touchPoint.x - center.x)
            let direction: CGFloat = sender.velocity(in: self).x > 0 ? -1.0 : 1.0
            angle *= direction
            let maxRotationAngle: CGFloat = .pi / 4
            let scalingFactor: CGFloat = 0.05
            let rotationAngle = scalingFactor * min(maxRotationAngle, max(-maxRotationAngle, angle))
            
            for button in buttons {
                let rotatedPoint = button.center.applying(CGAffineTransform(translationX: -center.x, y: -center.y))
                    .applying(CGAffineTransform(rotationAngle: rotationAngle))
                    .applying(CGAffineTransform(translationX: center.x, y: center.y))
                button.center = rotatedPoint
            }
            
            sender.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    
    
    
    
    
}




