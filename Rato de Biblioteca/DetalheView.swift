//
//  DetalheView.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 13/06/21.
//

import SwiftUI
import CoreData


struct DetalheView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var mostrandoAlertaDeletar = false
    let livro: Livro
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.livro.genero ?? "Fantasia")
                        .frame(maxWidth: geometry.size.width)

                    Text(self.livro.genero?.uppercased() ?? "FANTASIA")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.livro.autor ?? "Autor Desconhecido")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.livro.analise ?? "Sem análise")
                    .padding()

                NotaView(nota: .constant(Int(self.livro.nota)))
                    .font(.largeTitle)

                Spacer()
            }
        }
        .navigationBarTitle(Text(livro.titulo ?? "Livro Desconhecido"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.mostrandoAlertaDeletar.toggle()
                }) {
                    Image(systemName: "trash")
                }
            }
        }
        .alert(isPresented: $mostrandoAlertaDeletar) {
            Alert(title: Text("Deletar livro"), message: Text("Tem certeza?"), primaryButton: .destructive(Text("Deletar")) {
                    self.deletarLivro()
                }, secondaryButton: .cancel()
            )
        }
    }
    func deletarLivro() {
        moc.delete(livro)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetalheView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let livro = Livro(context: moc)
        livro.titulo = "Harry Potter"
        livro.autor = "Alguém"
        livro.genero = "Fantasia"
        livro.nota = 3
        livro.analise = "É um ótimo livro, adorei!"
        
        return NavigationView {
            DetalheView(livro: livro)
        }
    }
}
