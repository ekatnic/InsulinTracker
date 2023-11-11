//
//  SettingsView.swift
//  InsulinTracker
//
//  Created by Eli Medina on 11/5/23.
//

import Foundation

import SwiftUI

struct HistoryView: View
{
    var body: some View
    {
        ZStack {
            VStack {
                VStack{
                    History()
                    TestingView()
                }
            }
        }
        .padding()
    }
}

struct TestingView: View
{
    var body: some View
    {
        ZStack {
            VStack {
                VStack{
                    Text("TestingTestingTesting")
                }
            }
        }
        .padding()
    }
    
    
}
struct History: View
{
    var body: some View
    {
        VStack{
            HStack{
                    Text("History Page.")
                    Text("More History")
            }
        }.padding(.bottom)
    }
    
}
