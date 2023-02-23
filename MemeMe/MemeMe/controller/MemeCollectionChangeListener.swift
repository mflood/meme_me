//
//  MemeCollectionChangeListener.swift
//  MemeMe
//
//  Created by Matthew Flood on 2/23/23.
//

import Foundation

protocol MemeCollectionChangeListener: AnyObject {
    func handleMemeCollectionChanged()
}
