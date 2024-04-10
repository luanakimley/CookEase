//
//  Instruction.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import Foundation
import SwiftData

@Model
class Instruction : Codable {
    enum CodingKeys: CodingKey {
        case action
        case minutesTaken
        case image
    }
    
    var action : String
    var minutesTaken: Int = 0
    var image : Data?
    
    init(action: String = "", minutesTaken: Int = 0, image: Data? = nil) {
        self.action = action
        self.minutesTaken = minutesTaken
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        minutesTaken = try container.decode(Int.self, forKey: .minutesTaken)
        image = try container.decode(Data.self, forKey: .image)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(minutesTaken, forKey: .minutesTaken)
        try container.encode(image, forKey: .image)
    }
}
