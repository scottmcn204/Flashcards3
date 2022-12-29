//
//  flashcardEdit.swift
//  Flashcards3
//
//  Created by Scott McNally on 30/11/2021.
//

import SwiftUI

struct flashcardEdit: View {
    @Binding var flashData : Flashcard.Data
    var new : Bool
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Flashcard info")){
                    VStack {
                        if new == true{
                            Text("New Flashcard")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        TextField(
                            "Flashcard Name",
                            text: $flashData.name
                        ).padding()
                        TextField(
                            "Flashcard Subject",
                            text: $flashData.subject
                        ).padding()
                        TextField(
                            "Flashcard Description",
                            text: $flashData.description
                        ).padding()
                    }
                }

            }
        }
    }
}

struct flashcardEdit_Previews: PreviewProvider {
    static var previews: some View {
        flashcardEdit(flashData: .constant(Flashcard.data[0].data), new: false)
    }
}
