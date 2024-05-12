//
//  Observer.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

protocol Observable {
    associatedtype Binder
    var value: Binder? { get set }
    var listener: ((Binder?) -> ())? { get set }
    
    mutating func onNext(_ value: Binder?)
    mutating func changeBind(_ value: Binder?)
    mutating func bind(_ listener: @escaping (Binder?) -> ())
}

struct Observer<T>: Observable {
    typealias Binder = T
    
    var value: Binder? {
        get { _value }
        set {
            _value = newValue
            listener?(newValue)
        }
    }
    var listener: ((Binder?) -> ())?
    
    private var _value: Binder?
    
    init(_ value: Binder? = nil) {
        self.value = value
    }
    
    mutating func changeBind(_ value: Binder?) {
        self._value = value
    }
    
    mutating func onNext(_ value: Binder?) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping (Binder?) -> ()) {
        self.listener = listener
    }
}
