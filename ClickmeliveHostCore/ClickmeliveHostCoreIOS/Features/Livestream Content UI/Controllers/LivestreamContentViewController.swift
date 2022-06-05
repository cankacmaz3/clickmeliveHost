//
//  LivestreamContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit

public final class LivestreamContentViewController: UIViewController, Layouting {
    
    public typealias ViewType = LivestreamContentView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("deinit LivestreamContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
}

