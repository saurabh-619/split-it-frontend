//
//  Counter.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/10/22.
//

import Foundation
import Combine

class Counter: ObservableObject {
    @Published var count: Double = 0.0
    let end: Double
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private var bag = Set<AnyCancellable>()
    
    init(speed: Double, end: String) {
        self.timer = Timer.publish(every: speed, on: .main, in: .common).autoconnect()
        self.end = Double((Double(end) ?? 0.0).getTwoDigitString) ?? 0.0
    }
    
    func start() {
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.count < self.end { 
                    self.count += 0.01
                } else {
                    self.bag.removeAll()
                }
            }
            .store(in: &bag)
    }
}
