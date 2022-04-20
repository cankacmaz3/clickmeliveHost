//
//  LoadingView.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    private enum Constants {
        static let animationName: String = "Loading"
        static let bgColor: UIColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    static let instance = LoadingView()
    
    deinit {
        print("deinit LoadingView")
    }
    
    // MARK: - View inits
    var animationView: AnimationView = {
        let animationView = AnimationView()
        return animationView
    }()
    
    // MARK: - Lifecycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(restartAnimation), name: UIApplication.willEnterForegroundNotification
                    , object: nil)
        
        frame = CGRect(x: 0,
                       y: 0,
                   width: UIScreen.main.bounds.width,
                  height: UIScreen.main.bounds.height)
        
        backgroundColor = Constants.bgColor
        
        animationView.loopMode = .loop
        animationView.animation = Animation.named(Constants.animationName)
    }
    
    // MARK: - Actions
    @objc func restartAnimation() {
        animationView.play()
    }
    
    // MARK: - UI related methods
    private func setupViews() {
        addSubview(animationView)
        animationView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 200)
        animationView.anchorCenterXToSuperview()
        animationView.anchorCenterYToSuperview()
    }
    
    func showLoading(){
        DispatchQueue.main.async {
            self.animationView.play()
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            keyWindow?.addSubview(self)
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            self.animationView.stop()
            self.removeFromSuperview()
        }
    }
}

