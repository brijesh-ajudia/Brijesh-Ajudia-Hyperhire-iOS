//
//  SongsModelClass.swift
//  DemoHyperhire
//
//  Created by CloudPark Infotech on 06/12/24.
//

import Foundation

struct SongsITunes: Decodable {
    
    let resultCount : Int?
    let results     : [SongsModelClass]?
    
    enum CodingKeys: String, CodingKey {
        
        case resultCount = "resultCount"
        case results     = "results"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        resultCount = try values.decodeIfPresent(Int.self               , forKey: .resultCount )
        results     = try values.decodeIfPresent([SongsModelClass].self , forKey: .results     )
        
    }
    
}

struct SongsModelClass: Decodable {
    
    let wrapperType             : String?
    let kind                    : String?
    let collectionId            : Int?
    let trackId                 : Int?
    let artistName              : String?
    let collectionName          : String?
    let trackName               : String?
    let collectionCensoredName  : String?
    let trackCensoredName       : String?
    let collectionArtistId      : Int?
    let collectionArtistViewUrl : String?
    let collectionViewUrl       : String?
    let trackViewUrl            : String?
    let previewUrl              : String?
    let artworkUrl30            : String?
    let artworkUrl60            : String?
    let artworkUrl100           : String?
    let collectionPrice         : Double?
    let trackPrice              : Double?
    let trackRentalPrice        : Double?
    let collectionHdPrice       : Double?
    let trackHdPrice            : Double?
    let trackHdRentalPrice      : Double?
    let releaseDate             : String?
    let collectionExplicitness  : String?
    let trackExplicitness       : String?
    let discCount               : Int?
    let discNumber              : Int?
    let trackCount              : Int?
    let trackNumber             : Int?
    let trackTimeMillis         : Int?
    let country                 : String?
    let currency                : String?
    let primaryGenreName        : String?
    let contentAdvisoryRating   : String?
    let shortDescription        : String?
    let longDescription         : String?
    let hasITunesExtras         : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case wrapperType             = "wrapperType"
        case kind                    = "kind"
        case collectionId            = "collectionId"
        case trackId                 = "trackId"
        case artistName              = "artistName"
        case collectionName          = "collectionName"
        case trackName               = "trackName"
        case collectionCensoredName  = "collectionCensoredName"
        case trackCensoredName       = "trackCensoredName"
        case collectionArtistId      = "collectionArtistId"
        case collectionArtistViewUrl = "collectionArtistViewUrl"
        case collectionViewUrl       = "collectionViewUrl"
        case trackViewUrl            = "trackViewUrl"
        case previewUrl              = "previewUrl"
        case artworkUrl30            = "artworkUrl30"
        case artworkUrl60            = "artworkUrl60"
        case artworkUrl100           = "artworkUrl100"
        case collectionPrice         = "collectionPrice"
        case trackPrice              = "trackPrice"
        case trackRentalPrice        = "trackRentalPrice"
        case collectionHdPrice       = "collectionHdPrice"
        case trackHdPrice            = "trackHdPrice"
        case trackHdRentalPrice      = "trackHdRentalPrice"
        case releaseDate             = "releaseDate"
        case collectionExplicitness  = "collectionExplicitness"
        case trackExplicitness       = "trackExplicitness"
        case discCount               = "discCount"
        case discNumber              = "discNumber"
        case trackCount              = "trackCount"
        case trackNumber             = "trackNumber"
        case trackTimeMillis         = "trackTimeMillis"
        case country                 = "country"
        case currency                = "currency"
        case primaryGenreName        = "primaryGenreName"
        case contentAdvisoryRating   = "contentAdvisoryRating"
        case shortDescription        = "shortDescription"
        case longDescription         = "longDescription"
        case hasITunesExtras         = "hasITunesExtras"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        wrapperType             = try values.decodeIfPresent(String.self , forKey: .wrapperType             )
        kind                    = try values.decodeIfPresent(String.self , forKey: .kind                    )
        collectionId            = try values.decodeIfPresent(Int.self    , forKey: .collectionId            )
        trackId                 = try values.decodeIfPresent(Int.self    , forKey: .trackId                 )
        artistName              = try values.decodeIfPresent(String.self , forKey: .artistName              )
        collectionName          = try values.decodeIfPresent(String.self , forKey: .collectionName          )
        trackName               = try values.decodeIfPresent(String.self , forKey: .trackName               )
        collectionCensoredName  = try values.decodeIfPresent(String.self , forKey: .collectionCensoredName  )
        trackCensoredName       = try values.decodeIfPresent(String.self , forKey: .trackCensoredName       )
        collectionArtistId      = try values.decodeIfPresent(Int.self    , forKey: .collectionArtistId      )
        collectionArtistViewUrl = try values.decodeIfPresent(String.self , forKey: .collectionArtistViewUrl )
        collectionViewUrl       = try values.decodeIfPresent(String.self , forKey: .collectionViewUrl       )
        trackViewUrl            = try values.decodeIfPresent(String.self , forKey: .trackViewUrl            )
        previewUrl              = try values.decodeIfPresent(String.self , forKey: .previewUrl              )
        artworkUrl30            = try values.decodeIfPresent(String.self , forKey: .artworkUrl30            )
        artworkUrl60            = try values.decodeIfPresent(String.self , forKey: .artworkUrl60            )
        artworkUrl100           = try values.decodeIfPresent(String.self , forKey: .artworkUrl100           )
        collectionPrice         = try values.decodeIfPresent(Double.self , forKey: .collectionPrice         )
        trackPrice              = try values.decodeIfPresent(Double.self , forKey: .trackPrice              )
        trackRentalPrice        = try values.decodeIfPresent(Double.self , forKey: .trackRentalPrice        )
        collectionHdPrice       = try values.decodeIfPresent(Double.self , forKey: .collectionHdPrice       )
        trackHdPrice            = try values.decodeIfPresent(Double.self , forKey: .trackHdPrice            )
        trackHdRentalPrice      = try values.decodeIfPresent(Double.self , forKey: .trackHdRentalPrice      )
        releaseDate             = try values.decodeIfPresent(String.self , forKey: .releaseDate             )
        collectionExplicitness  = try values.decodeIfPresent(String.self , forKey: .collectionExplicitness  )
        trackExplicitness       = try values.decodeIfPresent(String.self , forKey: .trackExplicitness       )
        discCount               = try values.decodeIfPresent(Int.self    , forKey: .discCount               )
        discNumber              = try values.decodeIfPresent(Int.self    , forKey: .discNumber              )
        trackCount              = try values.decodeIfPresent(Int.self    , forKey: .trackCount              )
        trackNumber             = try values.decodeIfPresent(Int.self    , forKey: .trackNumber             )
        trackTimeMillis         = try values.decodeIfPresent(Int.self    , forKey: .trackTimeMillis         )
        country                 = try values.decodeIfPresent(String.self , forKey: .country                 )
        currency                = try values.decodeIfPresent(String.self , forKey: .currency                )
        primaryGenreName        = try values.decodeIfPresent(String.self , forKey: .primaryGenreName        )
        contentAdvisoryRating   = try values.decodeIfPresent(String.self , forKey: .contentAdvisoryRating   )
        shortDescription        = try values.decodeIfPresent(String.self , forKey: .shortDescription        )
        longDescription         = try values.decodeIfPresent(String.self , forKey: .longDescription         )
        hasITunesExtras         = try values.decodeIfPresent(Bool.self   , forKey: .hasITunesExtras         )
        
    }
    
}

class SongsAPI {
    
    static let sharedInstance: SongsAPI = {
        let instance = SongsAPI()
        return instance
    }()
    
    func fetchSongs(from urlString: String, with query: String, completion: @escaping (Result<SongsITunes, Error>) -> Void) {
        // Construct the full URL with query
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "term", value: query),
                                    URLQueryItem(name: "media", value: "music")] 
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URLComponents", code: 0, userInfo: nil)))
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Decode the JSON response into the SongsITunes model
                let decoder = JSONDecoder()
                let result = try decoder.decode(SongsITunes.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the task
        task.resume()
    }
}
