//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation
import Combine

public protocol GameRepositoryProtocol {
    func getListGame() -> AnyPublisher<[GameModel], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailModel?, Error>
    func insertFavGame(gameModel: GameModel) -> AnyPublisher<Bool, Error>
    func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error>
    func updateFaveGame(gameModel: GameModel) -> AnyPublisher<Bool, Error>
    func getFavGamesById(id: Int) -> AnyPublisher<GameModel?, Error>
    func getFavGames() -> AnyPublisher<[GameModel]?, Error>
}

final public class GameRepository: NSObject {
    
    public typealias GameInstance = (RemoteDataSource, LocalDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    public static let sharedInstance: GameInstance = { remote, local in
        return GameRepository(remote: remote, local: local)
    }
}

extension GameRepository: GameRepositoryProtocol {
    
    public func getListGame() -> AnyPublisher<[GameModel], Error> {
        return self.local.getGame()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getGameList()
                        .map {
                            mapGameEntity(responses: $0)
                        }
                        .map {
                            $0.forEach { entity in
                                self.local.insertGame(gameEntity: entity)
                            }
                        }
                        .flatMap {
                            self.local.getGame()
                        }
                        .map {
                            mapGame(entity: $0) ?? []
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getGame()
                        .map {
                            mapGame(entity: $0) ?? []
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    public func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailModel?, Error> {
        return self.local.getGameDetail(gameId: gameId)
            .flatMap { result -> AnyPublisher<GameDetailModel?, Error> in
                if result == nil {
                    return self.remote.getGameDetail(gameId: gameId)
                        .map {
                            mapGameDetailEntity(input: $0)
                        }
                        .map {
                            self.local.insertGameDetail(gameDetailEntity: $0)
                        }
                        .flatMap {
                            self.local.getGameDetail(gameId: gameId)
                        }
                        .map {
                            mapGameDetail(entity: $0) ?? nil
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getGameDetail(gameId: gameId)
                        .map {
                            mapGameDetail(entity: $0) ?? nil
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    public func insertFavGame(gameModel: GameModel) -> AnyPublisher<Bool, Error> {
        let favGameEntity = mapFavGameEntity(input: gameModel)
        return self.local.insertFavGame(favGameEntity: favGameEntity)
    }
    
    public func updateFaveGame(gameModel: GameModel) -> AnyPublisher<Bool, Error> {
        let favGameEntity = mapFavGameEntity(input: gameModel)
        return self.local.updateFavGame(favGameEntity: favGameEntity)
    }
    
    public func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.local.deleteFavGame(gameId: gameId)
    }
    
    public func getFavGamesById(id: Int) -> AnyPublisher<GameModel?, Error> {
        return self.local.getFavGamesById(id: id)
            .map {
                mapGame(favGamEntity: $0)
            }
            .eraseToAnyPublisher()
    }
    
    public func getFavGames() -> AnyPublisher<[GameModel]?, Error> {
        return self.local.getFavGames()
            .map {
                mapGame(favGamEntity: $0)
            }
            .eraseToAnyPublisher()
    }

}
