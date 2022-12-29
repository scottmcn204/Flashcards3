//
//  flashcardRow.swift
//  Flashcards3
//
//  Created by Scott McNally on 30/11/2021.
//

import SwiftUI

struct flashcardRow: View {
    //let flashcard : Flashcard
    @Binding var flashcard: Flashcard
    @State var n = false
    @State var isPresented = false
    @State var data: Flashcard.Data = Flashcard.Data()
    var body: some View {
        VStack{
            Spacer()
            Text(flashcard.name)
                .font(.title)
                .fontWeight(.bold)
            if n == false{
                Spacer()
                Button(action: {
                    n = true
                }, label: {
                    HStack {
                        Text("See Definition")
                        Image(systemName: "eye")
                    }
                }).padding()
            }
            if n == true{
                Text(flashcard.description).padding()
                Spacer()
                Spacer()
                Button(action: {
                    n = false
                }, label: {
                    HStack {
                        Text("Hide Definition")
                        Image(systemName: "eye.slash")
                    }
                }).padding()
            }
        }.navigationBarItems(trailing: Button("Edit"){
            isPresented = true
            data = flashcard.data
        })
            .fullScreenCover(isPresented: $isPresented){
                NavigationView{
                    flashcardEdit(flashData: $data, new: false)
                        .navigationTitle(flashcard.name)
                        .navigationBarItems(leading: Button("Cancel"){
                            isPresented = false
                        }, trailing: Button("Done"){
                            isPresented = false
                            flashcard.update(from: data)
                        })
                }
            }
    }
}

struct flashcardRow_Previews: PreviewProvider {
    static var previews: some View {
        flashcardRow(flashcard: .constant(Flashcard.data[0]))
    }
}
