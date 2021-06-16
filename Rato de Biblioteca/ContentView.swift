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
    @FetchRequest(entity: Livro.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Livro.titulo, ascending: true), NSSortDescriptor(keyPath: \Livro.autor, ascending: true)]) var livros: FetchedResults<Livro>
    
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
                .onDelete(perform: deletarLivro)
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
                   ToolbarItem(placement: .navigationBarLeading) {
                       EditButton()
                   }
               }
               .sheet(isPresented: $mostrandoTela) {
                   AdicionarLivroView().environment(\.managedObjectContext, self.moc)
               }
       }
    }
    
    func deletarLivro(at offsets: IndexSet) {
        for offset in offsets {
            // encontrar o livro na fetch request
            let livro = livros[offset]

            // deletar do context
            moc.delete(livro)
        }

        // salvar o context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
