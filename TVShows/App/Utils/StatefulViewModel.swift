//
//  StatefulViewModel.swift
//  TVShows
//
//  Created by Diggo Silva on 25/06/25.
//

import Combine

protocol StatefulViewModel {
    associatedtype State
    var statePublisher: AnyPublisher<State, Never> { get }
}
