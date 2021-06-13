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
            List {
                ForEach(livros, id: \.self) { livro in
                    NavigationLink(destination: DetalheView(livro: livro)) {
                        
                        EmojiNotaView(nota: livro.nota)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(livro.titulo ?? "Titulo Desconhecido")
                                .font(.headline)
                            Text(livro.autor ?? "Autor Desconhecido")
                                .foregroundColor(.secondary)
                            
                        }
                    }
                }
            }
               .navigationBarTitle("Rato de Biblioteca")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           self.mostrandoTela.toggle()
                       }) {
                           Image(systemName: "plus")
                       }
                   }
               }
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
