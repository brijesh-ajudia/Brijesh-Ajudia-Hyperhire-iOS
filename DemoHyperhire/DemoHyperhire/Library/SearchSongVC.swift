//
//  SearchSongVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

protocol AddSongDelegate {
    func addSong(song: SongsModelClass)
}

class SearchSongVC: BaseViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var tblSongs: UITableView!
    
    var delegate: AddSongDelegate?
    
    var allSongs: [SongsModelClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTableData()
    }
    

    func setUpTableData() {
        
        self.txtSearch.tag = 0
        self.txtSearch.delegate = self
        self.txtSearch.keyboardType = .default
        self.txtSearch.setAttributesPlaceHolder_Color(placeHolderString: "Enter playlist name")
        self.txtSearch.keyboardAppearance = .dark
        self.txtSearch.returnKeyType = .search
        self.txtSearch.addTarget(self, action: #selector(searchValidate), for: .editingDidEnd)
        
        self.tblSongs.registerHeader(headerType: PlaylistTVHCell.self)
        self.tblSongs.registerCell(cellType: PlaylistTVCell.self)
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

//MARK: - TextField Delegate Methods
extension SearchSongVC {
    
    @objc func searchValidate() {
        let searchText = self.txtSearch.text?.trim() ?? ""
        let nameCount = searchText.count
        
        if nameCount == 0 {
            
        }
        else {
            SongsAPI.sharedInstance.fetchSongs(from: BASE_URL, with: searchText) { result in
                switch result {
                case .success(let songs):
                    print("Result Count: \(songs.resultCount ?? 0)")
                    
                    self.allSongs = songs.results ?? []
                    self.tblSongs.reloadData()
                    
                    self.view.resignFirstResponder()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
     }
    
}

//MARK: - Button Actions
extension SearchSongVC {
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchSongVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlaylistTVHCell") as! PlaylistTVHCell
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 29
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 1))
        headerView.backgroundColor = UIColor._121212
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTVCell", for: indexPath) as! PlaylistTVCell
        
        let song = self.allSongs[indexPath.row]
        
        cell.lblSongName.text = song.trackName ?? ""
        cell.lblSongBy.text = song.artistName ?? ""
        
        cell.imgCover.loadImageFromProfile(urlString: song.artworkUrl60 ?? "", placeholderImage: UIImage(named: "img_SongPH"))
        
        cell.imgCover.cornerRadiuss = 26.0
        cell.btnMore.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 + 16
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = self.allSongs[indexPath.row]
        self.delegate?.addSong(song: song)
        self.navigationController?.popViewController(animated: true)
    }
    
}
