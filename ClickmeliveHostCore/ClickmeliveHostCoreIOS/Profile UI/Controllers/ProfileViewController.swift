//
//  ProfileViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import Foundation
import UIKit

public final class ProfileViewController: UIViewController, Layouting {
    public typealias ViewType = ProfileView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
}
