//
//  ListModel.swift
//  Grocery List
//
//  Created by students on 17/12/25.
//

import Foundation
import SwiftData
@Model
class Listt{
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
