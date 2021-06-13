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
                    Picker("Nota", selection: $nota) {
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }

                    TextField("Escreve uma análise para o filme", text: $analise)
                }

                Section {
                    Button("**Salvar**") {
                        let novoLivro = Livro(context: self.moc)
                        novoLivro.titulo = self.titulo
                        novoLivro.autor = self.autor
                        novoLivro.nota = Int16(self.nota)
                        novoLivro.genero = self.genero
                        novoLivro.analise = self.analise

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
