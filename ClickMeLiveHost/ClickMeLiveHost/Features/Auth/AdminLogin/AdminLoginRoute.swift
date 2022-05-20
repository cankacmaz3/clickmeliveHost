//
//  AdminLoginRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

protocol AdminLoginRoute {
    var adminLoginTransition: Transition { get }
    func openAdminLoginModule()
}

extension AdminLoginRoute where Self: RouterProtocol {
    func openAdminLoginModule() {
        let module = AdminLoginUIComposer.makeAdminLoginController(openTransition: adminLoginTransition)
        open(module, transition: adminLoginTransition)
    }
}
