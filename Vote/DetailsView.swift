//
//  DetailsView.swift
//  Vote
//
//  Created by Joshua Shane Martin on 2/4/25.
//

import SwiftUI

struct DetailsView: View {
    private var _subject: Subject
    
    @ObservedObject var fetcherScores: FetchScores
    
    init(subject: Subject) {
        _subject = subject
        fetcherScores = FetchScores(subjectId: String(_subject.id))
    }
    
    let columns = [GridItem(.flexible(minimum: 20, maximum: .infinity))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: HorizontalAlignment.leading) {
                    Text(_subject.name)
                        .font(.largeTitle)
                        .padding([.leading, .trailing], 10)
                        .padding([.top], 20)
                    
                    VStack {
                        HStack {
                            imageForScore(score: _subject.diversityScore)
                            Text("DEI")
                                .foregroundColor(Color.gray)
                                .font(.callout)
                                .padding([.trailing], 15)
                            
                            imageForScore(score: _subject.environmentalScore)
                            Text("Environment")
                                .foregroundColor(Color.gray)
                                .font(.callout)
                            
                            Spacer()
                        }
                        .padding([.bottom], 10)
                        
                        HStack {
                            imageForScore(score: _subject.unionScore)
                            Text("Unions")
                                .foregroundColor(Color.gray)
                                .font(.callout)
                                .padding([.trailing], 15)
                            
                            imageForScore(score: _subject.lobbyingScore)
                            Text("Politics")
                                .foregroundColor(Color.gray)
                                .font(.callout)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 12)
                    .padding([.bottom], 5)
                    
                    NavigationLink(destination: SuggestScoreView(subject: _subject)) {
                        Text("Suggest a Score")
                            .padding([.top, .bottom], 2)
                            .padding([.leading, .trailing], 5)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding([.leading, .trailing], 12)
                    .padding([.top], 15)
                    
                    Text("Diversity, Equity, and Inclusion")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding([.top], 20)
                        .padding([.leading, .trailing], 12)
                    
                    let diversityScores = fetcherScores.scores.filter({ score in score.topic == "Diversity" })
                    
                    if (diversityScores.isEmpty) {
                        Text("There are no reports on this topic, please help us by suggesting a score above.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding([.top], 5)
                            .padding([.leading, .trailing], 12)
                    }
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading) {
                        ForEach(diversityScores) { score in
                            Link(destination: URL(string: score.sourceUrl)!) {
                                Text(score.headline)
                                .multilineTextAlignment(.leading)
                            }
                            .padding([.top], 1)
                            .padding([.leading, .trailing], 12)
                            
                            let localizedDate = localizedDate(date: score.createdAt)
                            let createdByUserName = score.createdByUser.name
                            
                            Text("Created by \(createdByUserName) at \(localizedDate)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing], 12)
                        }
                    }
                    
                    Text("Environmental Stewardship and Responsibility")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding([.top], 20)
                        .padding([.leading, .trailing], 12)
                    
                    let environmentalScores = fetcherScores.scores.filter({ score in score.topic == "Environmental" })
                    
                    if (environmentalScores.isEmpty) {
                        Text("There are no reports on this topic, please help us by suggesting a score above.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding([.top], 5)
                            .padding([.leading, .trailing], 12)
                    }
                
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading) {
                        ForEach(environmentalScores) { score in
                            Link(destination: URL(string: score.sourceUrl)!) {
                                Text(score.headline)
                                .multilineTextAlignment(.leading)
                            }
                            .padding([.top], 1)
                            .padding([.leading, .trailing], 12)
                            
                            let localizedDate = localizedDate(date: score.createdAt)
                            let createdByUserName = score.createdByUser.name
                            
                            Text("Created by \(createdByUserName) at \(localizedDate)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing], 12)
                        }
                    }
                    
                    Text("Unions and Labor Protections")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding([.top], 20)
                        .padding([.leading, .trailing], 12)
                    
                    let unionScores = fetcherScores.scores.filter({ score in score.topic == "Unions" })
                    
                    if (unionScores.isEmpty) {
                        Text("There are no reports on this topic, please help us by suggesting a score above.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding([.top], 5)
                            .padding([.leading, .trailing], 12)
                    }
                
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading) {
                        ForEach(unionScores) { score in
                            Link(destination: URL(string: score.sourceUrl)!) {
                                Text(score.headline)
                                .multilineTextAlignment(.leading)
                            }
                            .padding([.top], 1)
                            .padding([.leading, .trailing], 12)
                            
                            let localizedDate = localizedDate(date: score.createdAt)
                            let createdByUserName = score.createdByUser.name
                            
                            Text("Created by \(createdByUserName) at \(localizedDate)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing], 12)
                        }
                    }
                    
                    Text("Lobbying and Political Spending")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .padding([.top], 20)
                        .padding([.leading, .trailing], 12)
                    
                    let politicsScores = fetcherScores.scores.filter({ score in score.topic == "Politics" })
                    
                    if (politicsScores.isEmpty) {
                        Text("There are no reports on this topic, please help us by suggesting a score above.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding([.top], 5)
                            .padding([.leading, .trailing], 12)
                    }
                
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading) {
                        ForEach(politicsScores) { score in
                            Link(destination: URL(string: score.sourceUrl)!) {
                                Text(score.headline)
                                .multilineTextAlignment(.leading)
                            }
                            .padding([.top], 1)
                            .padding([.leading, .trailing], 12)
                            
                            let localizedDate = localizedDate(date: score.createdAt)
                            let createdByUserName = score.createdByUser.name
                            
                            Text("Created by \(createdByUserName) at \(localizedDate)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing], 12)
                        }
                    }
                }
                .navigationTitle("Details")
                .padding([.top], 20)
                .padding([.bottom], 60)
            }
            .overlay() {
                ProgressView()
                    .controlSize(ControlSize.extraLarge)
                    .opacity(opacityForLoading(loading: fetcherScores.loading))
            }
        }
    }
    
    private func opacityForLoading(loading: Bool) -> Double {
        if (loading) {
            return 1
        } else {
            return 0
        }
    }
    
    private func imageForScore(score: Int) -> some View {
        
        if (score == 1) {
            Image("gpp_bad_gpp_bad_symbol")
                .resizable()
                .frame(width: 30, height: 36)
                .foregroundColor(.red)
        } else if (score == 3) {
            Image("verified_user_verified_user_symbol")
                .resizable()
                .frame(width: 30, height: 36)
                .foregroundColor(.green)
        } else if (score == 2) {
            Image("gpp_maybe_gpp_maybe_symbol")
                .resizable()
                .frame(width: 30, height: 36)
                .foregroundColor(.orange)
        } else {
            Image("shield_question_shield_question_symbol")
                .resizable()
                .frame(width: 30, height: 36)
                .foregroundColor(.gray)
        }
    }
    
    private func localizedDate(date: String) -> String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // 2025-01-27T04:32:00.000
        var utcDate = utcDateFormatter.date(from: date)
        
        if (utcDate == nil) {
            utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // 2025-01-27T04:32:00
            utcDate = utcDateFormatter.date(from: date)
            
            if (utcDate == nil) {
                return ""
            }
        }
        
        return DateFormatter.localizedString(from: utcDate!,
                                             dateStyle: .medium,
                                             timeStyle: .short)
    }
}

#Preview {
    let subject = Subject(name: "Walmart", id: 1)
    DetailsView(subject: subject)
}
