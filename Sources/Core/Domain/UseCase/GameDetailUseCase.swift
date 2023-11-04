//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation
import Combine

public protocol GameDetailUseCaseProtocol {
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailModel?, Error>
    func insertFavGame(gameModel: GameModel) -> AnyPublisher<Bool, Error>
    func updateFaveGame(gameModel: GameModel) -> AnyPublisher<Bool, Error>
    func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error>
    func getFavGamesById(id: Int) -> AnyPublisher<GameModel?, Error>
    func getFavGames() -> AnyPublisher<[GameModel]?, Error>
}

public final class GameDetailUseCase: NSObject {
    
    public typealias GameDetailUseCaseInstance = (GameRepositoryProtocol) -> GameDetailUseCase
    
    fileprivate let repository: GameRepositoryProtocol
    
    private init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public static let sharedInstance: GameDetailUseCaseInstance = { repository  in
        return GameDetailUseCase(repository: repository)
    }
}

extension GameDetailUseCase: GameDetailUseCaseProtocol {
    
    public func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailModel?, Error> {
        return repository.getGameDetail(gameId: gameId)
    }
    
    public func insertFavGame(gameModel: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.insertFavGame(gameModel: gameModel)
    }
    
    public func updateFaveGame(gameModel: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.updateFaveGame(gameModel: gameModel)
    }
    
    public func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavGame(gameId: gameId)
    }
    
    public func getFavGamesById(id: Int) -> AnyPublisher<GameModel?, Error> {
        return repository.getFavGamesById(id: id)
    }
    
    public func getFavGames() -> AnyPublisher<[GameModel]?, Error> {
        return repository.getFavGames()
    }

}
