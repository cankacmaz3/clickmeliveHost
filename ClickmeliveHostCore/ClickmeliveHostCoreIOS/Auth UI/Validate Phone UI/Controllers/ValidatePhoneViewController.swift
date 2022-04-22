//
//  ValidatePhoneViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import UIKit

public final class ValidatePhoneViewController: UIViewController, Layouting {
    public typealias ViewType = ValidatePhoneView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
}
