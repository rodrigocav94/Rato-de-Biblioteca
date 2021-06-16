//
//  AdicionarLivroView.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 12/06/21.
//

import SwiftUI

struct AdicionarLivroView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var titulo = ""
    @State private var autor = ""
    @State private var nota = 3
    @State private var genero = ""
    @State private var analise = ""
    
    let generos = ["Fantasia", "Terror", "Infantil", "Mistério", "Poesia", "Romance", "Suspense"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Nome do livro", text: $titulo)
                    TextField("Nome do autor", text: $autor)

                    Picker("Gênero", selection: $genero) {
                        ForEach(generos, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    NotaView(nota: $nota, imagemDesligada: Image(systemName: "star"), corLigada: .blue)
                    TextField("Escreve uma análise para o livro", text: $analise)
                }

                Section {
                    Button("**Salvar**") {
                        let novoLivro = Livro(context: self.moc)
                        novoLivro.titulo = self.titulo
                        novoLivro.autor = self.autor
                        novoLivro.nota = Int16(self.nota)
                        if self.genero != "" {
                            novoLivro.genero = self.genero
                        } else {
                            novoLivro.genero = "Gênero não especificado"
                        }
                        novoLivro.analise = self.analise
                        novoLivro.data = Date()

                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }.foregroundColor(.white)
                    .listRowBackground(Color.blue)
                }
            }
            .navigationBarTitle("Adicionar livro")
        }
    }
}

struct AdicionarLivroView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarLivroView()
    }
}
