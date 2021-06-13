//
//  NotaView.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 13/06/21.
//

import SwiftUI

struct NotaView: View {
    @Binding var nota: Int

    var rotulo = ""

    var notaMaxima = 5

    var imagemDesligada: Image?
    var imagemLigada = Image(systemName: "star.fill")

    var corDesligada = Color.gray
    var corLigada = Color.yellow
    
    func imagem(para numero: Int) -> Image {
        if numero > nota {
            return imagemDesligada ?? imagemLigada
        } else {
            return imagemLigada
        }
    }
    
    var body: some View {
        HStack {
            if rotulo.isEmpty == false {
                Text(rotulo)
            }

            ForEach(1..<notaMaxima + 1) { numero in
                self.imagem(para: numero)
                    .foregroundColor(numero > self.nota ? self.corDesligada : self.corLigada)
                    .onTapGesture {
                        self.nota = numero
                    }
            }
        }
    }
}

struct NotaView_Previews: PreviewProvider {
    static var previews: some View {
        NotaView(nota: .constant(4))
    }
}
