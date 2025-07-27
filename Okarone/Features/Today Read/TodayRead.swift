//
//  TodayRead.swift
//  Okarone
//
//  Created by Sourav on 27/7/25.
//

import SwiftUI

struct TodayRead: View {

    let text =
"""
   **বনলতা সেন**

হাজার বছর ধরে আমি পথ হাঁটিতেছি পৃথিবীর পথে,
সিংহল সমুদ্র থেকে নিশীথের অন্ধকারে মালয় সাগরে
অনেক ঘুরেছি আমি; বিম্বিসার-অশােকের ধূসর জগতে
সেখানে ছিলাম আমি; আরাে দূর অন্ধকারে বিদর্ভ নগরে;
আমি ক্লান্ত প্রাণ এক, চারিদিকে জীবনের সমুদ্র সফেন,
আমারে দু-দণ্ড শান্তি দিয়েছিল নাটোরের বনলতা সেন।


চুল তার কবেকার অন্ধকার বিদিশার নিশা,
মুখ তার শ্রাবন্তীর কারুকার্য; অতি দূর সমুদ্রের ’পর
হাল ভেঙে যে নাবিক হারায়েছে দিশা
সবুজ ঘাসের দেশ যখন সে চোখে দেখে দারুচিনি-দ্বীপের ভিতর,
তেমনি দেখেছি তারে অন্ধকারে, বলেছে সে, ‘এতদিন কোথায় ছিলেন?’
পাখির নীড়ের মতাে চোখ তুলে নাটোরের বনলতা সেন।


সমস্ত দিনের শেষে শিশিরের শব্দের মতন
সন্ধ্যা আসে; ডানার রৌদ্রের গন্ধ মুছে ফেলে চিল;
পৃথিবীর সব রঙ নিভে গেলে পাণ্ডুলিপি করে আয়ােজন
তখন গল্পের তরে জোনাকির রঙে ঝিলমিল;
সব পাখি ঘরে আসে—সব নদী—ফুরায় এ-জীবনের সব লেনদেন;
থাকে শুধু অন্ধকার, মুখােমুখি বসিবার বনলতা সেন।
"""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Today's Reading")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text(LocalizedStringKey(text))
                    .padding(.horizontal)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(1.2)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    TodayRead()
}

