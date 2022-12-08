//
//  DetailHeroView.swift
//  Funios-DotaApp
//
//  Created by Ade Dwi Prayitno on 08/12/22.
//

import SwiftUI

struct DetailHeroView: View {
    var dotaName: String
    @StateObject var detailHeroViewModel: DetailHeroViewModel = DetailHeroViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BackgroundColor")
            
            VStack(spacing: 5) {
                AsyncImage(url: URL(string: "https://api.opendota.com\(detailHeroViewModel.dotaHero[0].img)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }.frame(width: 385 ,height: 300)
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                HStack(spacing: 10) {
                    Text(detailHeroViewModel.dotaHero[0].localizedName)
                        .font(Font.custom("Proxima Nova Bold", size: 40))
                        .foregroundColor(.white)
                    Image(detailHeroViewModel.dotaHero[0].primaryAttr == "agi" ? "Agility" : "")
                    Spacer()
                }
                
                HStack {
                    ForEach(detailHeroViewModel.dotaHero[0].roles, id: \.self) { role in
                        Text(role)
                            .font(Font.custom("ProximaNova-Regular", size: 18))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
            }
            
        }.task {
            await detailHeroViewModel.getHeroStats(heroName: dotaName)
        }
        .ignoresSafeArea()
            
    }
}

struct DetailHeroView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeroView(dotaName: "Axe")
    }
}
