//
//  ProductDetailView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductDetailView: View {
    let productID: Int
    @StateObject var productDetailVM: ProductDetailViewModel = ProductDetailViewModel()

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: productDetailVM.product.image),
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
                Text("$\(productDetailVM.product.price.setMaximumFractions(2)) - \(productDetailVM.product.title)")
                    .font(.title3.bold())
                    .multilineTextAlignment(.leading)
                Spacer()
                Button{
                    productDetailVM.toggleFavorite(productID)
                }label:{
                    Image(systemName: productDetailVM.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            Divider()
            Text(productDetailVM.product.description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            Divider()
            List {
                Text("Category: \(productDetailVM.product.category)")
                Text("Rating: \(productDetailVM.product.rating.rate.setMaximumFractions(2)) (\(productDetailVM.product.rating.count) votes)")
            }
            .listStyle(.plain)
            .scrollDisabled(true)
            Spacer()
        }
        .onAppear{
            productDetailVM.getProduct(productID)
            productDetailVM.checkFavorite(productID)
        }
    }
}
