//
//  ProductDetailView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image),
                       content: { image in
                           image
                               .resizable()
                               .scaledToFit()
                               .frame(height: 240)
                               .clipShape(RoundedRectangle(cornerRadius: 8))
                               .shadow(radius: 1)
                       },
                       placeholder: {
                           ProgressView()
                       })
            HStack {
                Text("$\(product.price.setMaximumFractions(2)) - \(product.title)")
                    .font(.title3.bold())
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "star")
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            Divider()
            Text(product.description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            Divider()
            List {
                Text("Category: \(product.category)")
                Text("Rating: \(product.rating.rate.setMaximumFractions(2)) (\(product.rating.count) votes)")
            }
            .listStyle(.plain)
            .scrollDisabled(true)
            Spacer()
        }
    }
}
