//
//  flashcardList.swift
//  Flashcards3
//
//  Created by Scott McNally on 30/11/2021.
//

import SwiftUI

struct flashcardList: View {
    @Binding var flashs: [Flashcard]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresented = false
    @State var newFlashData = Flashcard.Data()
    @State var binTime = false
    let saveAction: () -> Void
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("   Add New")
                        .fontWeight(.bold)
                    Image(systemName: "plus.rectangle.fill")
                }).padding()
                Spacer()
            }
            //List(flashs){ f in
            List{
                ForEach(flashs, id: \.name){ f in
                    NavigationLink{
                        flashcardRow(flashcard: binding(for: f))
                    } label: {
                        HStack{
                            Text(f.name)
                                .font(.headline)
                            Text(f.subject)
                                .fontWeight(.light)
                                .foregroundColor(Color.blue)
                        }
                    }
                }.onDelete(perform: remove).padding()
            }.navigationTitle("Flashcards").sheet(isPresented: $isPresented){
                NavigationView{
                    flashcardEdit(flashData: $newFlashData, new: true).navigationBarItems(leading: Button("Dismiss"){
                        isPresented = false
                    }, trailing: Button ("Add"){
                        let newFlash = Flashcard(name: newFlashData.name, subject: newFlashData.subject, description: newFlashData.description)
                        flashs.append(newFlash)
                        isPresented = false
                    })
                }
            }.onChange(of: scenePhase) { phase in
                    if phase == .inactive {saveAction()}
            }
        }
    }
    private func binding(for flash: Flashcard) -> Binding<Flashcard> {
        guard let flashIndex = flashs.firstIndex(where: { $0.id == flash.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $flashs[flashIndex]
    }
    func remove(at offsets: IndexSet){
        flashs.remove(atOffsets: offsets)
    }
}


struct flashcardList_Previews: PreviewProvider {
    static var previews: some View {
        flashcardList(flashs: .constant(Flashcard.data), saveAction: {})
    }
}
