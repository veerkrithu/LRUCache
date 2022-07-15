//
//  LRUCache.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/13/22.
//

import Foundation
import UIKit

class LRUCache <Key: Hashable, Value> {
    
    var maxCapacity: Int = 0
    var data: [Key: Node<Key, Value>] = [:]
    var list: DoublyLinkedList<Key, Value> = DoublyLinkedList()
    
    init(maxCapacity: Int) {
        if maxCapacity <= 0 { fatalError() }
        self.maxCapacity = maxCapacity
    }
    
    deinit {
        data.removeAll()
        while (list.count > 0) {
            let _ = list.removeLast()
        }
    }
    
    func add(key: Key, value: Value) {
        if let node = data[key] {
            list.moveToHead(node: node)
        }
        else {
            guard let node = list.addHead(key, value) else { fatalError()}
            data[key] = node
        }
        
        if list.count > maxCapacity {
            guard let node = list.removeLast() else { return }
            data[node.key] = nil
        }
    }
    
    func get(key: Key)-> Value? {
        guard let node = data[key] else { return nil }
        list.moveToHead(node: node)
        return node.value
    }
    
    func isValid(key: Key)-> Bool {
        return (data[key] != nil)
    }
}
