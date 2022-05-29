//
//  DefaultsStore.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

public protocol DefaultsStore {
    func saveUser(_ user: User)
    func loadUser() -> User?
    func deleteUser()
}
