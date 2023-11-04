//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation
import Combine

public protocol LocalDataSourceProtocol: AnyObject {
    func getGame() -> AnyPublisher<[GameEntity], Error>
    func getGameById(gameId: Int) -> AnyPublisher<[GameEntity], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailEntity?, Error>
    func insertGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
    func updateGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGame(gameId: Int) -> AnyPublisher<Bool, Error>
    
    func getFavGames() -> AnyPublisher<[FavGameEntity], Error>
    func getFavGamesById(id: Int) -> AnyPublisher<FavGameEntity?, Error>
    func insertFavGame(favGameEntity: FavGameEntity) -> AnyPublisher<Bool, Error>
    func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error>
}

final public class LocalDataSource: NSObject {
    public typealias LocalDataSourceInstance = (GameDbProvider, FavGameDbProvider) -> LocalDataSource
    
    fileprivate let gameDbProvider: GameDbProvider
    fileprivate let favGameDbProvider: FavGameDbProvider
    
    init(gameDbProvider: GameDbProvider, favGameDbProvider: FavGameDbProvider) {
        self.gameDbProvider = gameDbProvider
        self.favGameDbProvider = favGameDbProvider
    }
    public static let sharedInstance: LocalDataSourceInstance = { gameDbProvider, favGameDbProvider in
        return LocalDataSource(gameDbProvider: gameDbProvider, favGameDbProvider: favGameDbProvider)
    }

}

extension LocalDataSource: LocalDataSourceProtocol {
    
   //MARK: Game
   
   public func getGame() -> AnyPublisher<[GameEntity], Error> {
       return gameDbProvider.getGame()
   }
   
   public func getGameById(gameId: Int) -> AnyPublisher<[GameEntity], Error> {
       return gameDbProvider.getGameById(gameId: gameId)
   }
   
    public func getGameDetail(gameId: Int) -> AnyPublisher<GameDetailEntity?, Error> {
       return gameDbProvider.getGameDetail(gameId: gameId)
   }
   
    public func insertGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
       return gameDbProvider.insertGame(gameEntity: gameEntity)
   }
   
    public func insertGameDetail(gameDetailEntity: GameDetailEntity) -> AnyPublisher<Bool, Error> {
       return gameDbProvider.insertGameDetail(gameDetailEntity: gameDetailEntity)
   }
   
    public func updateGame(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
       return gameDbProvider.updateGame(gameEntity: gameEntity)
   }
   
    public func deleteGame(gameId: Int) -> AnyPublisher<Bool, Error> {
       return gameDbProvider.deleteGame(gameId: gameId)
   }
   
   //MARK: Fav Game
   
    public func insertFavGame(favGameEntity: FavGameEntity) -> AnyPublisher<Bool, Error> {
       return favGameDbProvider.insertFavGame(favGameEntity: favGameEntity)
   }
   
    public func updateFavGame(favGameEntity: FavGameEntity) -> AnyPublisher<Bool, Error> {
       return favGameDbProvider.updateFavGame(favGameEntity: favGameEntity)
   }
   
    public func deleteFavGame(gameId: Int) -> AnyPublisher<Bool, Error> {
       return favGameDbProvider.deleteFavGame(gameId: gameId)
   }
   
    public func getFavGames() -> AnyPublisher<[FavGameEntity], Error> {
       return favGameDbProvider.getFavGame()
   }
   
    public func getFavGamesById(id: Int) -> AnyPublisher<FavGameEntity?, Error> {
       return favGameDbProvider.getFavGameById(gameId: id)
   }
}
