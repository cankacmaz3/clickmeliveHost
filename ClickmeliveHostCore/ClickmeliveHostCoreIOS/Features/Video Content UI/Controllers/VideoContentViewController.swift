//
//  VideoContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit

public final class VideoContentViewController: UIViewController, Layouting {
    
    public typealias ViewType = VideoContentView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("deinit VideoContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
}

