//
//  ContentView.swift
//  InsulinTracker
//
//  Created by Ethan Katnic on 10/31/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                NavigationStack{
                    VStack{
                        EntryHeader()
                    }.frame(maxWidth: .infinity, alignment: .center)
                    GroupBox{
                        VStack{
                            TimeSelector()
                            EntryTypeSelector()
                            BloodSugarSelector()
                            EnteredBySelector()
                            ValidatedBySelector()
                            Note()
                        }
                    }.groupBoxStyle(CustomGroupBoxStyle())
                    


                    RecommendationPanel()
                    Spacer()
                    NavBar()
                }
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomGroupBoxStyle: GroupBoxStyle {
    var backgroundColor: UIColor = UIColor.systemGroupedBackground
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
            configuration.content
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20, style: .circular)
            .fill(Color(backgroundColor)))
    }
}


struct EntryHeader: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"pencil").resizable().frame(width:30,height:20)
                Text("Entry").font(.system(size:30, weight: .medium))
            }
        }.padding(.bottom)
    }
}

struct TimeSelector: View {
    var body: some View {
        VStack{
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("Time").font(.system(size:20, weight: .medium)) })
        }.padding([.top, .leading])
    }
}

struct EntryTypeSelector: View {

    enum entryTypes : String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case other = "Other"
    }

    let buttons: [String] = entryTypes.allCases.map { $0.rawValue }
    
    @State private var selectedEntryType: entryTypes = entryTypes.breakfast;
    @State public var buttonSelected: String?
    
    var body: some View {
        VStack{
            Text("Entry Type").font(.system(size:18, weight: .medium)).frame(maxWidth: .infinity, alignment: .leading)
            
        }.padding([.top, .leading])
        HStack{
            ForEach(buttons, id: \.self) { button in
                Button(action: {
                    self.buttonSelected = button
                }) {
                    Text(button).font(.system(size:16))
                }.foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(self.buttonSelected == button ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }
        }
    }
    
    
}

struct BloodSugarSelector: View {
    @State private var bloodSugarLevel = "0";

    var body: some View {
        VStack{
            HStack{
                Text("Blood Sugar Level").font(.system(size:18, weight: .medium))
                //Enforces that input must be a valid integer
                TextField("BloodSugarLevel", text: $bloodSugarLevel)
                    .keyboardType(.numberPad)
                    .onReceive(Just(bloodSugarLevel)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.bloodSugarLevel = filtered
                        }
                    }.padding([.leading])
            }
        }.padding([.top, .leading])
    }
    
    public func getBloodSugarLevel() -> Int? {
        return Int(self.bloodSugarLevel)
    }
}

struct EnteredBySelector: View {
    @State private var enteredByName = "";

    var body: some View {
        VStack{
            HStack{
                Text("Entered By").font(.system(size:18, weight: .medium))
                Spacer()
                TextField("Name", text: $enteredByName).onReceive(Just(enteredByName)) { enteredByName in
                        self.enteredByName = enteredByName
                    }
                }
        }.padding([.top, .leading])
    }
}

struct ValidatedBySelector: View {
    @State private var validatedByName: String = "";
    @State private var validatedByPin : String = "";

    var body: some View {
        VStack{
            HStack{
                Text("Validated By").font(.system(size:17, weight: .medium)).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                TextField("Name", text: $validatedByName).onReceive(Just(validatedByName)) { validatedByName in
                    self.validatedByName = validatedByName
                }
                Text("Pin").font(.system(size:15, weight: .medium))
                TextField("Pin", text: $validatedByPin)
                    .keyboardType(.numberPad)
                    .onReceive(Just(validatedByPin)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.validatedByPin = filtered
                        }
                    }
            }
        }.padding([.top, .leading])
    }
}

struct Note: View {
    @State private var noteText: String = "Write your note here..."

    var body: some View {
        VStack{
            TextEditor(text: $noteText).onReceive(Just(noteText)) { noteText in
                self.noteText = noteText
            }.font(.custom("HelveticaNeue", size: 13))
                .frame(width: 326.0, height: 100)
        }.padding(.leading)
    }
}

struct RecommendationPanel: View {
    @State private var noteText: String = "Placeholder of Dosage"

    var body: some View {
        VStack{
            Text(self.noteText)
            HStack {
                Button(action: {}) {
                    Text("Calculate Dosage")
                }
                .padding([.top, .trailing], 20.0)
                
                Button(action: {}) {
                    Text("Submit ")
                }
                .padding([.top, .leading], 20.0)

            }
        }.padding([.top, .bottom], 25)
    }
}
struct NavBar: View
{
    var body: some View
    {
            HStack(spacing:45)
            {
                //Entry Button
                NavigationLink{
                    EntryView()
                } label:{
                    VStack
                    {//VStack is needed if you want Text underneath image.
                        Image(systemName: "syringe")
                            .resizable()
                            .frame(width:40, height:40)
                            .foregroundColor(.black)
                        Text("Entry")
                            .foregroundColor(.black )
                    }
                    
                }

                
                //History Button
                NavigationLink{
                    HistoryView()
                }label:{
                    VStack
                    {
                        Image(systemName: "calendar.badge.clock")
                            .resizable()
                            .frame(width:40, height:40)
                            .foregroundColor(.black)
                        Text("History")
                            .foregroundColor(.black)
                    }
                }
                
                //Profile Button
                NavigationLink{
                    ProfileView()
                }label:{
                    VStack
                    {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width:40, height:40)
                            .foregroundColor(.black)
                        Text("Profile")
                            .foregroundColor(.black)
                    }
                }

                
                //Settings/More Button
                NavigationLink{
                    SettingsView()
                    } label:{
                        VStack
                        {
                            Image(systemName: "ellipsis.rectangle")
                                .resizable()
                                .frame(width:40, height:40)
                                .foregroundColor(.black)
                            Text("More")
                                .foregroundColor(.black)
                        }
                    }
                }
    }
}
