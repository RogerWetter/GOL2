//
//  ContentView.swift
//  GOL2
//
//  Created by roger wetter on 17.04.23.
//

import SwiftUI

let 🫷🏼 = 100
let 🤏🏼 = 50

func createRandomField() -> [[Int]] {
    var field = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    for 👉🏼 in 0..<🤏🏼 {
        for 👆🏼 in 0..<🫷🏼 {
            field[👉🏼][👆🏼] = Int(arc4random() % 2)
        }
    }
    return field
}

func createNewField(oldField: [[Int]]) -> [[Int]] {
    var field = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    for 👉🏼 in 0..<🤏🏼 {
        for 👆🏼 in 0..<🫷🏼 {
            let 👀 = get👀(oldField: oldField, 👉🏼: 👉🏼, 👆🏼: 👆🏼)
            if (oldField[👉🏼][👆🏼] == 0) {
                if (👀 == 3) {field[👉🏼][👆🏼] = 1}
            } else {
                switch 👀 {
                case 2, 3:
                    field[👉🏼][👆🏼] = 1
                default:
                    break
                }
            }
        }
    }
    return field
}

func get👀(oldField: [[Int]], 👉🏼: Int, 👆🏼: Int) -> Int {
    var 👀 = 0
    for i in 👉🏼 - 1...👉🏼+1 {
        for j in 👆🏼 - 1...👆🏼+1 {
            if (i >= 0 && j >= 0 && i < 🤏🏼 && j < 🫷🏼 && !(i==👉🏼 && j==👆🏼)) {
                if (oldField[i][j] == 1) {👀 = 👀+1}
            }
        }
    }
    return 👀
}

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var field = createRandomField()
    
    var body: some View {
        VStack(spacing: 14.0) {
            Text("Conway’s Game of Life").font(Font.headline)
            FieldView(field: field).onReceive(timer) { time in
                field = createNewField(oldField: field)
                print("The time is now \(time)")
            }
            HStack() {
                Button("random") {
                    field = createRandomField()
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                Button("next") {
                    field = createNewField(oldField: field)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            }.padding()
        }
        .padding()
    }
}

struct FieldView: View {
    var field: [[Int]]
    var body: some View {
        Grid {
            ForEach(0..<🤏🏼) {
                👉🏼 in
                GridRow {
                    ForEach(0..<🫷🏼) {
                        👆🏼 in
                        IconView(alive: field[👉🏼][👆🏼])
                    }
                }
                
            }
        }
        
    }
}

struct IconView: View {
    let alive: Int
    let size = 900.0 // mac
//    let size = 180.0 // phone
    var body: some View {
        if (alive == 1) {
            Image(systemName: "heart.fill").resizable().frame(width: size/CGFloat(🫷🏼), height: size/CGFloat(🫷🏼))
        } else {
            Image(systemName: "cross").resizable().frame(width: size/CGFloat(🫷🏼), height: size/CGFloat(🫷🏼))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
