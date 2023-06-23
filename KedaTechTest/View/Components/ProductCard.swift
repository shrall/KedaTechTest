//
//  ProductCard.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image),
                       content: { image in
                           image
                               .resizable()
                               .scaledToFill()
                               .frame(width: 100, height: 100)
                               .clipShape(Circle())
                               .shadow(radius: 2)
                       },
                       placeholder: {
                           ProgressView()
                       })
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .lineLimit(1)
                    .bold()
                Text(product.category)
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                HStack {
                    Text("$\(product.price.setMaximumFractions(2))")
                        .font(.headline.bold())
                        .padding(.top, 8)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background()
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
