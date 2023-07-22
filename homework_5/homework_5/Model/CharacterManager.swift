import Foundation

protocol CharacterManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterResponseModel], Error>) -> Void)
}

class CharacterManager: CharacterManagerProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchCharacters(completion: @escaping (Result<[CharacterResponseModel], Error>) -> Void) {
        networkManager.fetchCharacters { (result: Result<ResultsResponseModel, Error>) in
            switch result {
            case .success(let response):
                let characters = response.characters
                completion(.success(characters))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
