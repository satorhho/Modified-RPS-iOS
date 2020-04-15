//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lance Kent Briones on 4/15/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var arr = ["Rock", "Paper", "Scissors"]
    @State private var choice: Int = Int.random(in: 0..<3)
    @State private var decide: Bool = Bool.random()
    
    @State private var player_choice: String = ""
    
    @State private var state_counter: Int = 0
    @State private var point_counter: Int = 0
    
    @State private var show_alert: Bool = false
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [.yellow, .purple, .pink, .orange]), center: .top, startRadius: 100, endRadius: 550)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 100){
                VStack{
                    Text(" \(self.arr[choice].uppercased())")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .fontWeight(.black)
                    
                    (self.decide ? Text("WIN").foregroundColor(.green) : Text("LOSE").foregroundColor(.red))
                        .font(.largeTitle)
                        
                }
                HStack{
                    VStack{
                        ForEach(0..<3){ i in
                            Button(action: {
                                self.set(player_choice: self.arr[i])
                                self.reset()
                            }) {
                                Image(decorative: "\(self.arr[i])")
                                    .renderingMode(.original)
                                    .frame(width: 175, height: 175)
                            }.padding()
                        }
                    }
                }
            }.alert(isPresented: $show_alert, content: {
                Alert(title: Text("Game's Done!"), message: Text("Your score is \(self.point_counter)\n Game is restarting."), dismissButton: .default(Text("Restart")){
                        self.full_reset()
                    })
            })
        }
    }
    
    func full_reset() -> Void {
        self.choice = Int.random(in: 0..<3)
        self.decide = Bool.random()
        self.state_counter = 0
        self.point_counter = 0
        self.show_alert = false
        
    }
    func reset() -> Void {
        self.choice = Int.random(in: 0..<3)
        self.decide = Bool.random()
        self.state_counter += 1
        
        if self.state_counter == 10{
            show_alert = true
        }
    }
    func set(player_choice: String) -> Void{
        self.player_choice = player_choice
        
        self.gatherpoint(choice: player_choice)
    }
    func gatherpoint(choice: String) -> Void {
        switch self.choice {
        case 0:
            if self.decide{
                if self.player_choice == "Paper"{
                    self.point_counter += 1
                }
            } else {
                if self.player_choice == "Scissors"{
                    self.point_counter += 1
                }
            }
        case 1:
            if self.decide{
                if self.player_choice == "Scissors"{
                    self.point_counter += 1
                }
            } else {
                if self.player_choice == "Rock"{
                    self.point_counter += 1
                }
            }
        default:    //Scissors
            if self.decide{
                if self.player_choice == "Rock"{
                    self.point_counter += 1
                }
            } else {
                if self.player_choice == "Paper"{
                    self.point_counter += 1
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
