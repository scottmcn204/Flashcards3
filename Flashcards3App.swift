//
//  Flashcards3App.swift
//  Flashcards3
//
//  Created by Scott McNally on 30/11/2021.
//

import SwiftUI

@main
struct Flashcards3Appcopy: App {
    @ObservedObject private var data = flashcardData()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                flashcardList(flashs: $data.flashs) {
                    data.save()
                }
            }.onAppear{
                data.load()
            }
        }
    }
}
