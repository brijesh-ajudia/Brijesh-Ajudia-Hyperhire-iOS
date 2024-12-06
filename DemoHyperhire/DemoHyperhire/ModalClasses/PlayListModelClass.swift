//
//  PlayListModelClass.swift
//  DemoHyperhire
//
//  Created by CloudPark Infotech on 06/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

struct PlayListModelClass: Decodable {
    let playlists : [Playlists]?
    
    enum CodingKeys: String, CodingKey {
        case playlists = "playlists"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        playlists = try values.decodeIfPresent([Playlists].self , forKey: .playlists )
    }
    
}


struct Playlists: Decodable {
    let playlistId: String?
    let name      : String?
    let cover     : String?
    let owner     : String?
    let songCount : Int?
    let songs     : [Songs]?
    
    enum CodingKeys: String, CodingKey {
        
        case playlistId = "playlistId"
        case name       = "name"
        case cover      = "cover"
        case owner      = "owner"
        case songCount  = "songCount"
        case songs      = "songs"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        playlistId  = try values.decodeIfPresent(String.self    , forKey: .playlistId      )
        name        = try values.decodeIfPresent(String.self    , forKey: .name            )
        cover       = try values.decodeIfPresent(String.self    , forKey: .cover           )
        owner       = try values.decodeIfPresent(String.self    , forKey: .owner           )
        songCount   = try values.decodeIfPresent(Int.self       , forKey: .songCount       )
        songs       = try values.decodeIfPresent([Songs].self   , forKey: .songs           )
        
    }
    
}

struct Songs: Decodable {
    let songId     : String?
    let title      : String?
    let artist     : String?
    let albumCover : String?
    
    enum CodingKeys: String, CodingKey {
        
        case songId     = "songId"
        case title      = "title"
        case artist     = "artist"
        case albumCover = "albumCover"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        songId     = try values.decodeIfPresent(String.self , forKey: .songId     )
        title      = try values.decodeIfPresent(String.self , forKey: .title      )
        artist     = try values.decodeIfPresent(String.self , forKey: .artist     )
        albumCover = try values.decodeIfPresent(String.self , forKey: .albumCover )
        
    }
    
}

struct PlayListModelName {
    static let firestore = "playlists"
    
}

class PlaylistAPI {
    
    static let sharedInstance: PlaylistAPI = {
        let instance = PlaylistAPI()
        return instance
    }()
    
    static let db = Firestore.firestore().collection(PlayListModelName.firestore)
    static let storage = Storage.storage().reference()
    
    func createPlaylist(playlist: [String: Any], completion: @escaping (Result<Bool, Error>) -> ()) {
        let id = playlist["playlistId"] as? String ?? ""
        PlaylistAPI.db.document(id).setData(playlist) { error in
            if let error {
                completion(.failure(error))
            }
            else {
                completion(.success(true))
            }
        }
    }
    
    func fetchPlaylists(success: @escaping([Playlists])->(), failure: @escaping(Error)->()) {
        PlaylistAPI.db.getDocuments { snapShot, error in
            if let error = error {
                failure(error)
                return
            }
            
            guard let documents = snapShot?.documents else {
                success([]) // Return empty array if no documents found
                return
            }
            
            var playlists: [Playlists] = []
            let decoder = JSONDecoder()
            
            do {
                for doc in documents {
                    let data = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let playlist = try decoder.decode(Playlists.self, from: data)
                    playlists.append(playlist)
                }
                success(playlists)
            } catch {
                failure(error)
            }
        }
    }
    
    func fetchPlaylist(id: String, completion: @escaping (Playlists?) -> ()) {
        PlaylistAPI.db.document(id).getDocument { response, error in
            if let document = response {
                do {
                    let decoder = JSONDecoder()
                    let data = try JSONSerialization.data(withJSONObject: document.data() ?? [:], options: [])
                    let playlist = try decoder.decode(Playlists.self, from: data)
                    completion(playlist)
                }
                catch {
                    completion(nil)
                }
            }
            else {
                completion(nil)
            }
        }
    }
    
    func addSongToPlaylist(playlistId: String, song: Songs, completion: @escaping (Result<Bool, Error>) -> ()) {
        // Reference to the playlist document
        let playlistRef = PlaylistAPI.db.document(playlistId)
        
        // Fetch the current playlist data
        playlistRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Playlist not found."])))
                return
            }
            
            // Parse the existing playlist data
            var playlistData = document.data() ?? [:]
            var songs = playlistData["songs"] as? [[String: Any]] ?? []
            let songCount = playlistData["songCount"] as? Int ?? 0
            
            // Add the new song to the songs array
            let newSong: [String: Any] = [
                "songId": song.songId ?? "",
                "title": song.title ?? "",
                "artist": song.artist ?? "",
                "albumCover": song.albumCover ?? ""
            ]
            songs.append(newSong)
            
            // Update the cover image if this is the first song being added
            if songCount == 0, let songCover = song.albumCover {
                playlistData["cover"] = songCover
            }
            
            // Increment the song count and update the playlist data
            playlistData["songCount"] = songCount + 1
            playlistData["songs"] = songs
            
            // Save the updated playlist data back to Firestore
            playlistRef.setData(playlistData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }

    
    func uploadPlaylist_SongImage(_ title: String, _ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let scaledImage = image.pngData() else {
            return completion(nil)
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        let imageReference = PlaylistAPI.storage.child("\(title)/\(imageName)")
        imageReference.putData(scaledImage, metadata: metadata) { _, _ in
            imageReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
}
