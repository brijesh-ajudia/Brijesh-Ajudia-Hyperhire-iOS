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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPlaylist.text = self.playlistName

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
        self.navigationController?.pushViewController(searchSongVC, animated: true)
    }
}

extension PlaylistLibraryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTVCell", for: indexPath) as! PlaylistTVCell
        
        cell.imgCover.cornerRadiuss = 0
        cell.btnMore.isHidden = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 + 16
    }
    
    
    
    
}
