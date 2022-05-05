//
//  UIViewController+Extensions.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 3.05.2022.
//


import UIKit

protocol UIViewControllerLifecycleObserver {
    func remove()
}

extension UIViewController {
    @discardableResult
    func onViewDidLoad(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewDidLoadCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewWillAppear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewWillAppearCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewWillDisappear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewWillDisappearCallback: callback
        )
        add(observer)
        return observer
    }
    
    private func add(_ observer: UIViewController) {
        addChild(observer)
        observer.view.isHidden = true
        view.addSubview(observer.view)
        observer.didMove(toParent: self)
    }
}

private class ViewControllerLifeCycleObserver: UIViewController, UIViewControllerLifecycleObserver {
  
    private var viewDidLoadCallback: () -> Void = {}
    private var viewWillAppearCallback: () -> Void = {}
    private var viewWillDisappearCallback: () -> Void = {}
   
    convenience init(viewDidLoadCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewDidLoadCallback = viewDidLoadCallback
    }
    
    convenience init(viewWillAppearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewWillAppearCallback = viewWillAppearCallback
    }
    
    convenience init(viewWillDisappearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewWillDisappearCallback = viewWillDisappearCallback
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        viewWillAppearCallback()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        viewWillDisappearCallback()
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
