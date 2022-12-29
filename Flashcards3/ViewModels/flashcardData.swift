//
//  flashcardData.swift
//  Flashcards3
//
//  Created by Scott McNally on 01/12/2021.
//

import Foundation

class flashcardData: ObservableObject{
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    static var fileURL: URL {
        return documentsFolder.appendingPathComponent("flashcard.data")
    }
    @Published var flashs: [Flashcard] = []
    
    func load(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.flashs = Flashcard.data
                }
                #endif
                return
            }
            guard let flashcarddata = try? JSONDecoder().decode([Flashcard].self, from: data) else {
                fatalError("Can't decode saved data.")
            }
            DispatchQueue.main.async {
                self?.flashs = flashcarddata
            }
        }
    }
    func save(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let flashs = self?.flashs else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(flashs) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}

