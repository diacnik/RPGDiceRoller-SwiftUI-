//
//  ContentView.swift
//  RPGDiceRoller(SwiftUI)
//
//  Created by Ian Kincaid on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    // dice images
    @State var dice_image:String = "dicegeneral" // d6
    @State var dice_image1:String = "dice10general" // d10
    @State var dice_image2:String = "dice10general" // d10
    
    // dice results
    @State var dice_result: String = "Waiting" // d6
    @State var dice_result1: String = "Waiting" // d10
    @State var dice_result2: String = "Waiting" // d10
    
    // strings used for selection
    @State private var stat: String = "Edge"
    @State private var statValue: String = "0"
    @State private var mod: String = "0"
    @State private var edge: String = "0"
    @State private var heart: String = "0"
    @State private var iron: String = "0"
    @State private var shadow: String = "0"
    @State private var wits: String = "0"
    @State private var momentum: String = "0"
    
    // values used for calculations
    @State var statValueInt = 0
    @State var modInt = 0
    @State var momentumInt = 0
    @State var rollResult = 0
    @State var momentumResult = 0
    
    // arrays holding possible values for mod, stats, statValues, momentum
    let mods = ["-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5"]
    let stats = ["Edge", "Heart", "Iron", "Shadow", "Wits"]
    let statValues = ["0", "1", "2", "3", "4"]
    let momentumNumbers = ["-6", "-5", "-4", "-3", "-2", "-1", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var body: some View {
        // select between two tabs, Dice and Character
        TabView(selection: $selection) {
            Form {
                VStack {
                    Spacer()
                    // Title of tab
                    Text("Dice Roller")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    // stack containing d10 dice images
                    HStack {
                        Image(self.dice_image1)
                            .resizable().frame(width: 100, height: 100)
                        Spacer()
                        Image(self.dice_image2)
                            .resizable().frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    // image of d6
                    Image(self.dice_image)
                        .resizable().frame(width: 100, height: 100)
                    Spacer()
                    // text result
                    Text(self.dice_result)
                        .font(.title)
                        .padding(.top, 50)
                        .padding(.bottom, 30)
                    Spacer()
                    // button to roll with stat and mod
                    Button("Roll!", action: {
                        
                        // generate random numbers to simulate dice rolls
                        let randomNumber = arc4random_uniform(6) + 1 // d6
                        let randomNumber1 = arc4random_uniform(10) + 1 // d10
                        let randomNumber2 = arc4random_uniform(10) + 1 // d10
                        
                        // update dice images
                        switch randomNumber {
                        case 1:
                            self.dice_image = "dice1"
                        case 2:
                            self.dice_image = "dice2"
                        case 3:
                            self.dice_image = "dice3"
                        case 4:
                            self.dice_image = "dice4"
                        case 5:
                            self.dice_image = "dice5"
                        case 6:
                            self.dice_image = "dice6"
                        default:
                            return
                        }
                        
                        switch randomNumber1 {
                        case 1:
                            self.dice_image1 = "dice10-1"
                        case 2:
                            self.dice_image1 = "dice10-2"
                        case 3:
                            self.dice_image1 = "dice10-3"
                        case 4:
                            self.dice_image1 = "dice10-4"
                        case 5:
                            self.dice_image1 = "dice10-5"
                        case 6:
                            self.dice_image1 = "dice10-6"
                        case 7:
                            self.dice_image1 = "dice10-7"
                        case 8:
                            self.dice_image1 = "dice10-8"
                        case 9:
                            self.dice_image1 = "dice10-9"
                        case 10:
                            self.dice_image1 = "dice10-10"
                        default:
                            return
                        }
                        
                        switch randomNumber2 {
                        case 1:
                            self.dice_image2 = "dice10-1"
                        case 2:
                            self.dice_image2 = "dice10-2"
                        case 3:
                            self.dice_image2 = "dice10-3"
                        case 4:
                            self.dice_image2 = "dice10-4"
                        case 5:
                            self.dice_image2 = "dice10-5"
                        case 6:
                            self.dice_image2 = "dice10-6"
                        case 7:
                            self.dice_image2 = "dice10-7"
                        case 8:
                            self.dice_image2 = "dice10-8"
                        case 9:
                            self.dice_image2 = "dice10-9"
                        case 10:
                            self.dice_image2 = "dice10-10"
                        default:
                            return
                        }
                        
                        // set statValue equal to selected stat for roll
                        switch stat {
                        case "Edge":
                            self.statValue = edge
                        case "Heart":
                            self.statValue = heart
                        case "Iron":
                            self.statValue = iron
                        case "Shadow":
                            self.statValue = shadow
                        case "Wits":
                            self.statValue = wits
                        default:
                            return
                        }
                        
                        // calculate rollResult
                        let statValueInt = Int(statValue) ?? 0 // cast statValue to int and store as statValueInt
                        let modInt = Int(mod) ?? 0 // cast mod to int and store as modInt
                        rollResult = Int(randomNumber) + statValueInt + modInt // add d6 roll to selected stat and modifier
                        
                        // determine if the roll is a strong hit, weak hit, or miss, and display message
                        if (rollResult >= randomNumber1 && rollResult >= randomNumber2) { // if result >= both d10s
                            self.dice_result = "Strong Hit!"
                        }
                        else if (rollResult >= randomNumber1 && rollResult < randomNumber2) { // if d10 <= result < d10
                            self.dice_result = "Weak Hit!"
                        }
                        else if (rollResult < randomNumber1 && rollResult >= randomNumber2) { // if d10 <= result < d10
                            self.dice_result = "Weak Hit!"
                        }
                        else { // results < both d10s
                            self.dice_result = "Pay the Price!"
                        }
                        
                    })
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    
                    // button to roll with momentum
                    Button("Use Momentum!", action: {
                        
                        // generate random numbers to simulate dice rolls
                        let randomNumber = arc4random_uniform(6) + 1
                        let randomNumber1 = arc4random_uniform(10) + 1
                        let randomNumber2 = arc4random_uniform(10) + 1
                        
                        // update dice images
                        switch randomNumber {
                        case 1:
                            self.dice_image = "dice1"
                        case 2:
                            self.dice_image = "dice2"
                        case 3:
                            self.dice_image = "dice3"
                        case 4:
                            self.dice_image = "dice4"
                        case 5:
                            self.dice_image = "dice5"
                        case 6:
                            self.dice_image = "dice6"
                        default:
                            return
                        }
                        
                        switch randomNumber1 {
                        case 1:
                            self.dice_image1 = "dice10-1"
                        case 2:
                            self.dice_image1 = "dice10-2"
                        case 3:
                            self.dice_image1 = "dice10-3"
                        case 4:
                            self.dice_image1 = "dice10-4"
                        case 5:
                            self.dice_image1 = "dice10-5"
                        case 6:
                            self.dice_image1 = "dice10-6"
                        case 7:
                            self.dice_image1 = "dice10-7"
                        case 8:
                            self.dice_image1 = "dice10-8"
                        case 9:
                            self.dice_image1 = "dice10-9"
                        case 10:
                            self.dice_image1 = "dice10-10"
                        default:
                            return
                        }
                        
                        switch randomNumber2 {
                        case 1:
                            self.dice_image2 = "dice10-1"
                        case 2:
                            self.dice_image2 = "dice10-2"
                        case 3:
                            self.dice_image2 = "dice10-3"
                        case 4:
                            self.dice_image2 = "dice10-4"
                        case 5:
                            self.dice_image2 = "dice10-5"
                        case 6:
                            self.dice_image2 = "dice10-6"
                        case 7:
                            self.dice_image2 = "dice10-7"
                        case 8:
                            self.dice_image2 = "dice10-8"
                        case 9:
                            self.dice_image2 = "dice10-9"
                        case 10:
                            self.dice_image2 = "dice10-10"
                        default:
                            return
                        }
                        
                        // calculate rollResult
                        let momentumInt = Int(momentum) ?? 0 // cast momentum as int and store in momentumInt
                        momentumResult = Int(randomNumber) + momentumInt // add randomNumber to momentum
                        
                        // determine if the roll is a strong hit, weak hit, or miss, and display message
                        if (momentumResult >= randomNumber1 && rollResult >= randomNumber2) {
                            self.dice_result = "Strong Hit!"
                        }
                        else if (momentumResult >= randomNumber1 && rollResult < randomNumber2) {
                            self.dice_result = "Weak Hit!"
                        }
                        else if (momentumResult < randomNumber1 && rollResult >= randomNumber2) {
                            self.dice_result = "Weak Hit!"
                        }
                        else {
                            self.dice_result = "Pay the Price!"
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    
                    // stack containing Stat picker menu and Modifier picker menu
                    HStack {
                        Picker("Stat", selection: $stat) { // label menu Stat and store selected value as stat
                            ForEach(stats, id: \.self) { // iterate over array stats for selection options
                                Text($0) // place string elements of array in menu, starting at index 0
                            }
                        }
                        Spacer()
                        Picker("Modifier", selection: $mod) {
                            ForEach(mods, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.top)
                }
            }
            .tabItem { Text("Dice") }.tag(0)
            
            Form {
                VStack {
                    Spacer()
                    Text("Character") // title of second tab
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 25)
                    Spacer()
                    // picker menus for individual stat values
                    Picker("Edge", selection: $edge) {
                        ForEach(statValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    Spacer()
                    Picker("Heart", selection: $heart) {
                        ForEach(statValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    Spacer()
                    Picker("Iron", selection: $iron) {
                        ForEach(statValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    Spacer()
                    Picker("Shadow", selection: $shadow) {
                        ForEach(statValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    Spacer()
                    Picker("Wits", selection: $wits) {
                        ForEach(statValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    Spacer()
                    
                    // picker menu for momentum
                    Picker("Momentum", selection: $momentum) {
                        ForEach(momentumNumbers, id: \.self) {
                            Text($0)
                        }
                    }
                    .padding()
                }
                .pickerStyle(.menu)
            }
            .tabItem { Text("Character") }.tag(1)
        }
    }
}


 #Preview {
     ContentView()
 }
