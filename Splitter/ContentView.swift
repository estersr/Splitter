//
//  ContentView.swift
//  WeSplit
//
//  Created by Esther Ramos on 18/08/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totalWithTips / peopleCount
        
        return amountPerPerson
    }
    
    var totalWithTips: Double {
        let fullPrice = Double(checkAmount) ?? 0
        let tipPrice = Double(tipPercentages[tipPercentage])
        let tipPercentage = fullPrice / 100 * tipPrice
        
        let pricePlusTip = fullPrice + tipPercentage
        
        return pricePlusTip
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Full price", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Amount of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much do you want leave as tip?")) {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Full price with tip")) {
                    Text("$\(totalWithTips, specifier: "%.2f")")
                }
                Section(header: Text("Each person will pay:")) {
                    if totalPerPerson >= 0 && totalPerPerson != Double.infinity {
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 4 ? .red : .primary)
                    } else {
                        Text("$0.00")
                            .foregroundColor(tipPercentage == 4 ? .red : .primary)
                    }

                }
            }
            .navigationBarTitle("Splitter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
