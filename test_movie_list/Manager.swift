

import Alamofire

import Foundation


public class NetworkManager {
    static let shared = NetworkManager()
    private static let apiKey = "912d840bd43a35998d00f87d102d5fc3"
    
    private var guestSessionId: String?
    private var sessionExpiryDate: Date?
    
    
    private init() {}
    
    // Function to get or refresh guest session
    func getGuestSession(completion: @escaping (Result<String, Error>) -> Void) {
        // Check if session exists and is valid
        if let guestSessionId = guestSessionId, let expiryDate = sessionExpiryDate, expiryDate > Date() {
            completion(.success(guestSessionId))
            print("\nguestSessionID\n", guestSessionId, "\n\n")
        } else {
            // Fetch new guest session
            fetchGuestSession { result in
                switch result {
                case .success(let newSession):
                    self.guestSessionId = newSession.id
                    self.sessionExpiryDate = newSession.expiryDate
                    completion(.success(newSession.id))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Function to fetch new guest session from the API
    private func fetchGuestSession(completion: @escaping (Result<GuestSession, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/authentication/guest_session/new"
        let parameters: [String: Any] = ["api_key": NetworkManager.apiKey]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MTJkODQwYmQ0M2EzNTk5OGQwMGY4N2QxMDJkNWZjMyIsIm5iZiI6MTcyMzM3ODkxMi4yODQzMDUsInN1YiI6IjY2YjEwY2RmYWYxMTdjZjk2NTA1MmNlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GfONoO23sLA7wW6xGe82Z7Ke3suGGr27jJ0aKmAYEdU"
        ]

        
        print("\nfetching guestSessionID\n")
        
        AF.request(url, parameters: parameters, headers: headers).responseDecodable(of: GuestSessionResponse.self) { response in
                    switch response.result {
                    case .success(let guestSessionResponse):
                        if guestSessionResponse.success {
                            let session = GuestSession(id: guestSessionResponse.guestSessionId, expiryDate: guestSessionResponse.expiryDate ?? Date())
                            completion(.success(session))
                        } else {
                            completion(.failure(NSError(domain: "TMDb", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create guest session"])))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        
        
    }
    
    // Function to update session expiry date after successful API request
    func updateSessionExpiryDate() {
        if let expiryDate = sessionExpiryDate {
            sessionExpiryDate = expiryDate.addingTimeInterval(3600) // Extend by 1 hour
        }
    }
    
    // Method to fetch rated movies
    func fetchRatedMovies(page: Int = 1, completion: @escaping (Result<RatedMoviesResponse, Error>) -> Void) {
        getGuestSession { result in
            switch result {
            case .success(let sessionId):
                let url = "https://api.themoviedb.org/3/account/\(sessionId)/rated/movies"
                let parameters: [String: Any] = [
                    "api_key": NetworkManager.apiKey,
                    "language": "en-US",
                    "page": page,
                    "session_id": sessionId,
                    "sort_by": "created_at.asc"
                ]
                
                let headers: HTTPHeaders = [
                    "accept": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZjhmZWNjZDk4MGUxMDU2MDRkMmQ5MTM1ZDZjYTI1MiIsIm5iZiI6MTcyMzM0ODE1MC40OTcwODEsInN1YiI6IjY2YjEwY2RmYWYxMTdjZjk2NTA1MmNlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z9WIMxuuMuDBc8pK6bZJ1jGSkMqgbPkzE9WuX_QeQRg"
                ]

                
                
                AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { resp in
                    switch resp.result {
                            case .success(let guestSessionResponse):
                                print("Guest session ID: \(guestSessionResponse)")
                            case .failure(let error):
                                print("Decoding failed with error: \(error)")
                            }
                }
//                responseDecodable(of: RatedMoviesResponse.self) { response in
//                    switch response.result {
//                    case .success(let movieResponse):
//                        // Update the session expiry date after a successful request
//                        self.updateSessionExpiryDate()
//                        completion(.success(movieResponse))
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
