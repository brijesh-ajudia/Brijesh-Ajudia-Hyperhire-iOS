//
//  PlaylistLibraryVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

class PlaylistLibraryVC: UIViewController {
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblPlaylist: UILabel!
    @IBOutlet weak var lblSongsCount: UILabel!
    
    @IBOutlet weak var tblSongs: UITableView!
    
    var playlistName: String = ""
    
    var playlist: Playlists?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPlaylist.text = self.playlist?.name ?? ""
        self.lblSongsCount.text = "\(self.playlist?.songCount ?? 0) songs"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.viewMain.applyGradientBackground()
            
            self.setUpTableData()
        }
    }
    
    func setUpTableData() {
        self.tblSongs.registerCells(cellTypes: [PlaylistTVCell.self])
        self.tblSongs.backgroundColor = UIColor._121212
        self.tblSongs.separatorStyle = .none
        self.tblSongs.showsVerticalScrollIndicator = false
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.tblSongs.tableHeaderView = UIView(frame: frame)
        
        self.tblSongs.tableFooterView = UIView(frame: .zero)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tblSongs.contentInset = insets
        self.tblSongs.sectionHeaderTopPadding = 0
        self.tblSongs.contentInsetAdjustmentBehavior = .never
        self.tblSongs.isUserInteractionEnabled = true
        
        self.tblSongs.delegate = self
        self.tblSongs.dataSource = self
    }


}

//MARK: - Button Actions
extension PlaylistLibraryVC {
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSongsAction(_ sender: UIButton) {
        let searchSongVC = Utils.loadVC(strStoryboardId: StoryBoard.SB_LIBRARY, strVCId: ViewControllerID.VC_SearchSong) as! SearchSongVC
        searchSongVC.delegate = self
        self.navigationController?.pushViewController(searchSongVC, animated: true)
    }
}

extension PlaylistLibraryVC: AddSongDelegate {
    func addSong(song: SongsModelClass) {
        let id = self.playlist?.playlistId ?? ""
        
        var songDict: [String: Any] = [:]
        
        songDict["songId"]  = String(song.trackId ?? 0)
        songDict["title"]  = song.trackName ?? ""
        songDict["artist"]  = song.artistName ?? ""
        songDict["albumCover"]  = song.artworkUrl60 ?? ""
        
        PlaylistAPI.sharedInstance.addSongToPlaylist(playlistId: id, song: songDict) { result in
            switch result {
            case .success(let success):
                
                
                
            case .failure(let error):
                print("")
            }
        }
    }
    
    
}

extension PlaylistLibraryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlist?.songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTVCell", for: indexPath) as! PlaylistTVCell
        
        let song = self.playlist?.songs?[indexPath.row]
        
        cell.imgCover.loadImageFromProfile(urlString: song?.albumCover ?? "", placeholderImage: UIImage(named: "img_SongPH"))
        
        cell.lblSongName.text = song?.title ?? ""
        cell.lblSongBy.text = song?.artist ?? ""
        
        cell.imgCover.cornerRadiuss = 0
        cell.btnMore.isHidden = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 + 16
    }
    
    
    
    
}
