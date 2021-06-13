//
//  ContentView.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 12/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Livro.entity(), sortDescriptors: []) var livros: FetchedResults<Livro>
    
    @State private var mostrandoTela = false
    
    var body: some View {
        NavigationView {
           Text("Conta: \(livros.count)")
               .navigationBarTitle("Rato de Biblioteca")
               .navigationBarItems(trailing: Button(action: {
                   self.mostrandoTela.toggle()
               }) {
                   Image(systemName: "plus")
               })
               .sheet(isPresented: $mostrandoTela) {
                   AdicionarLivroView().environment(\.managedObjectContext, self.moc)
               }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
