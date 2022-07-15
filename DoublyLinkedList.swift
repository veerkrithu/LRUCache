//
//  DoublyLinkedList.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/13/22.
//

import Foundation

class Node<Key, Value> {
    var key: Key
    var value: Value
    var next: Node?
    var previous: Node?
    
    init (key: Key, value: Value, next: Node? = nil, previous: Node? = nil) {
        self.key = key
        self.value = value
        self.next = next
        self.previous = previous
    }
}

class DoublyLinkedList<Key, Value> {
    var count: UInt = 0
    var head: Node<Key, Value>?
    var tail: Node<Key, Value>?
    
    func addHead(_ key: Key, _ value: Value)-> Node<Key, Value>? {
        
        let node = Node(key: key, value: value)
        count += 1
        guard let tempHead = head, let _ = tail else {
            head = node
            tail = head
            return node
        }
        
        tempHead.previous = node
        node.previous = tempHead
        head = node
        return node
    }
    
    func removeLast()->Node<Key, Value>? {
        guard let tempTail = tail else { return nil }
        
        let previous = tempTail.previous
        previous?.next = nil
        defer {
            count -= 1
            tail = previous
        }
        return tail
    }
    
    func moveToHead(node: Node<Key, Value>) {
        guard head !== node else { return }
        
        if tail === node { tail = node.previous }
        node.previous?.next = node.next
        node.next?.previous = node.previous
        
        node.previous = nil
        node.next = head
        
        head?.previous = node
        head = node
    }
    
}
