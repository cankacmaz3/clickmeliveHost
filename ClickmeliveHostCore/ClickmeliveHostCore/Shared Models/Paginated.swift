//
//  Paginated.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

public enum Paginated<T> {
    indirect case node(T?, ((@escaping (Result<Paginated<T>, Error>) -> Void) -> ())?)
        
    public var value: T? {
        if case let Paginated.node(value, _) = self {
            return value
        }
        return nil
    }
    
    public var next: ((@escaping (Result<Paginated<T>, Error>) -> Void) -> ())? {
        if case let Paginated.node(_, next) = self {
            return next
        }
        return nil
    }
}
