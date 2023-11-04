//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation
import Combine

public protocol GameUseCaseProtocol {
    func getListGame() -> AnyPublisher<[GameModel], Error>
}

public final class GameUseCase: NSObject {
    
    public typealias HomeGameUseCaseInstance = (GameRepositoryProtocol) -> GameUseCase
    
    fileprivate let repository: GameRepositoryProtocol
    
    private init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public static let sharedInstance: HomeGameUseCaseInstance = { repository  in
        return GameUseCase(repository: repository)
    }
}

extension GameUseCase: GameUseCaseProtocol {
    
    public func getListGame() -> AnyPublisher<[GameModel], Error> {
        return repository.getListGame()
    }
    
}

