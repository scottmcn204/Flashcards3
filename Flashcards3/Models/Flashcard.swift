//
//  Flashcard.swift
//  Flashcards3
//
//  Created by Scott McNally on 30/11/2021.
//

import Foundation

struct Flashcard : Identifiable, Codable{
    var name = ""
    var subject = ""
    var description = ""
    var id:UUID?
    //var colour = ""
    
    init(id: UUID = UUID(), name: String, subject: String, description: String) {
        self.id = id
        self.name = name
        self.subject = subject
        self.description = description
        //self.colour = colour
    }
}
extension Flashcard {
    static var data : [Flashcard] {
        [
            Flashcard(name: "Example Flashcard", subject: "Example", description: "This flashcard is for testing purposes only please, I mean really please do not try and learn this flashcard, it is simply used for testing, feel free to delete")
        ]
    }
}
extension Flashcard {
    struct Data {
        var name: String = ""
        var subject: String = ""
        var description: String = ""
        //var colour: String = ""
    }

    var data: Data {
        return Data(name: name, subject: subject, description: description)
    }

    mutating func update(from data: Data) {
        name = data.name
        subject = data.subject
        description = data.description
       // colour = data.colour
    }
}


