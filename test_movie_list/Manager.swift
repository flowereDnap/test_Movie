

import Alamofire

public class NetworkManager {
    static let shared = NetworkManager()
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
        let apiKey = "YOUR_API_KEY"
        let parameters: [String: Any] = ["api_key": apiKey]
        
        print("\nfetching guestSessionID\n")
        
        AF.request(url, parameters: parameters).responseJSON { response in
            
            print("\nresult of session fetch\n", response.value)
            
            switch response.result {
            case .success(let guestSessionResponse):
                print("Response JSON: \(guestSessionResponse)")
                /*if guestSessionResponse.success {
                    let session = GuestSession(id: guestSessionResponse.guestSessionId, expiryDate: guestSessionResponse.expiryDate!)
                    completion(.success(session))
                } else {
                    completion(.failure(NSError(domain: "TMDb", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create guest session"])))
                }*/
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
                let url = "https://api.themoviedb.org/3/account/{account_id}/rated/movies"
                let parameters: [String: Any] = [
                    "api_key": "YOUR_API_KEY",
                    "language": "en-US",
                    "page": page,
                    "session_id": sessionId,
                    "sort_by": "created_at.asc"
                ]
                
                AF.request(url, parameters: parameters).responseDecodable(of: RatedMoviesResponse.self) { response in
                    switch response.result {
                    case .success(let movieResponse):
                        // Update the session expiry date after a successful request
                        self.updateSessionExpiryDate()
                        completion(.success(movieResponse))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
