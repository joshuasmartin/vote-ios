//
//  SubjectsView.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/3/25.
//

import SwiftUI

struct SubjectsView: View {
    @Namespace var namespace
    
    enum SubjectType {
        case none, retailers, brands
    }
    
    @State private var title: String
    
    @ObservedObject var fetcherRetailers = FetchRetailers()
    
    @ObservedObject var fetcherBrands = FetchBrands()
    
    let _filter: SubjectType
    
    let columns = [GridItem(.flexible(minimum: 20, maximum: .infinity))]
    
    init(filter: SubjectType) {
        _filter = filter
        
        switch _filter {
        case .retailers:
            title = "Retailers"
        default:
            title = "Brands"
        }
    }
    
    var body: some View {
        
        let subjects = {
            switch _filter {
            case .retailers:
                return fetcherRetailers.subjects
            default:
                return fetcherBrands.subjects
            }
        }()
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading) {
                    ForEach(subjects) { subject in
                        
                        NavigationLink {
                            DetailsView(subject: subject) // Destination
                        } label:  {
                            
                            VStack(alignment: HorizontalAlignment.leading) {
                                Text(subject.name)
                                    .font(.title2)
                                    .padding([.leading, .trailing], 6)
                                
                                HStack {
                                    
                                    imageForScore(score: subject.diversityScore)
                                    Text("DEI")
                                        .foregroundColor(Color.gray)
                                        .font(.callout)
                                    
                                    imageForScore(score: subject.environmentalScore)
                                    Text("Environment")
                                        .foregroundColor(Color.gray)
                                        .font(.callout)
                                    
                                    imageForScore(score: subject.unionScore)
                                    Text("Unions")
                                        .foregroundColor(Color.gray)
                                        .font(.callout)
                                    
                                    imageForScore(score: subject.lobbyingScore)
                                    Text("Politics")
                                        .foregroundColor(Color.gray)
                                        .font(.callout)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding([.leading, .trailing], 8)
                                .padding([.bottom], 10)
                                
                                Divider()
                                    .overlay(Color.gray)
                                    .frame(minHeight: 1)
                            }
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .trailing], 5)
                            .padding([.bottom, .top], 5)
                        }
                    }
                }
                .padding([.bottom], 60)
            }
            .overlay() {
                ProgressView()
                    .controlSize(ControlSize.extraLarge)
                    .opacity(opacityForLoading(loadingBrands: fetcherBrands.loading,
                                               loadingRetailers: fetcherRetailers.loading))
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func opacityForLoading(loadingBrands: Bool, loadingRetailers: Bool) -> Double {
        if (loadingBrands || loadingRetailers) {
            return 1
        } else {
            return 0
        }
    }
    
    private func imageForScore(score: Int) -> some View {
        
        if (score == 1) {
            Image("gpp_bad_gpp_bad_symbol")
                .resizable()
                .frame(width: 20, height: 24)
                .foregroundColor(.red)
        } else if (score == 3) {
            Image("verified_user_verified_user_symbol")
                .resizable()
                .frame(width: 20, height: 24)
                .foregroundColor(.green)
        } else if (score == 2) {
            Image("gpp_maybe_gpp_maybe_symbol")
                .resizable()
                .frame(width: 20, height: 24)
                .foregroundColor(.orange)
        } else {
            Image("shield_question_shield_question_symbol")
                .resizable()
                .frame(width: 20, height: 24)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    SubjectsView(filter: .brands)
}
