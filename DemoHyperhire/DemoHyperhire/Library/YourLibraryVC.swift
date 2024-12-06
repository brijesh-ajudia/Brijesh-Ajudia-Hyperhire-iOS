//
//  YourLibraryVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit
import FloatingPanel

class YourLibraryVC: UIViewController {
    
    @IBOutlet weak var clvList: UICollectionView!
    
    var fpcPlaylist: FloatingPanelController!
    
    var allPlaylists: [Playlists] = []
    
    var menuListStyle: MenuListType = .ListView {
        didSet {
            self.clvList.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.updateLayout()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpClvData()
    }
    
    // MARK: - Set Up TableView Data
    func setUpClvData() {
        self.clvList.register(cellTypes: [GridCVCell.self, ListCVCell.self])
        
        self.clvList.collectionViewLayout = self.createListLayout()
        self.clvList.delegate = self
        self.clvList.dataSource = self
        self.clvList.backgroundColor = UIColor._121212
        self.clvList.isUserInteractionEnabled = true
        
        self.updateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllPlaylists { isDataFetch, modalClass in
            if isDataFetch == true {
                self.clvList.reloadData()
            }
        }
    }
    
    // MARK: - Layout Updates
    private func updateLayout(animated: Bool = true) {
        self.clvList.collectionViewLayout = self.menuListStyle == .GridView ? createGridLayout() : createListLayout()
        self.clvList.reloadData()
    }
    
    private func createGridLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 16
        let availableWidth = self.clvList.frame.width - (padding * 2)
        let itemWidth = (availableWidth - 14) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: 216)
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        return layout
    }
    
    private func createListLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 2
        
        layout.itemSize = CGSize(width: self.clvList.frame.width, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        return layout
    }

}

extension YourLibraryVC {
    
    func getAllPlaylists(_ callback: ((_ isDataFetch: Bool, _ modalClass: [Playlists]) -> Void)?) {
        PlaylistAPI.sharedInstance.fetchPlaylists { playLists in
            if playLists.count > 0 {
                self.allPlaylists = playLists
                callback?(true, playLists)
            }
        } failure: { error in
            print("Not fetching playlists Error ->", error.localizedDescription)
            callback?(false, [])
        }

    }
}

// MARK: - Floating Controller for Country Selection
extension YourLibraryVC: FloatingPanelControllerDelegate {
    func setUpFloatingForLabourFilter() {
        fpcPlaylist = FloatingPanelController()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 8
        appearance.backgroundColor = UIColor._333333
        fpcPlaylist.surfaceView.appearance = appearance
        fpcPlaylist.delegate = self
        fpcPlaylist.isRemovalInteractionEnabled = true
        fpcPlaylist.surfaceView.containerView.layer.cornerRadius = 0.0
        fpcPlaylist.surfaceView.containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        fpcPlaylist.surfaceView.grabberHandle.isHidden = true
        if let playlistVC = Utils.loadVC(strStoryboardId: StoryBoard.SB_LIBRARY, strVCId: ViewControllerID.VC_Playlist) as? PlaylistVC {
            playlistVC.delegate = self
            fpcPlaylist.set(contentViewController: playlistVC)
            self.present(fpcPlaylist, animated: true, completion: nil)
        }
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        if vc == fpcPlaylist {
            return SetUpPlaylist()
        }
        else {
            return defaultSelectionView()
        }
    }
}

extension YourLibraryVC: PlaylistDelagate {
    func filterLabour(isClicked: Bool) {
        self.fpcPlaylist.dismiss(animated: true) {
            let createPlaylist = Utils.loadVC(strStoryboardId: StoryBoard.SB_LIBRARY, strVCId: ViewControllerID.VC_CreatPlaylist) as! CreatPlaylistVC
            createPlaylist.delegate = self
            createPlaylist.modalPresentationStyle = .pageSheet
            self.present(createPlaylist, animated: true, completion: nil)
        }
    }
}

extension YourLibraryVC:  CreatPlaylistDelagate {
    func createdPlaylist(name: String) {
        
        let id = PlaylistAPI.db.document().documentID
        
        var playlist: [String: Any] = [:]
        playlist["playlistId"] = id
        playlist["name"] = name
        playlist["cover"] = ""
        playlist["owner"] = "self"
        playlist["songCount"] = 0
        playlist["songs"] = []
        
        PlaylistAPI.sharedInstance.createPlaylist(playlist: playlist) { result in
            switch result {
            case .success(let success):
                
                let playlistLibraryVC = Utils.loadVC(strStoryboardId: StoryBoard.SB_LIBRARY, strVCId: ViewControllerID.VC_PlaylistLibrary) as! PlaylistLibraryVC
                playlistLibraryVC.playlistName = name
                
                do {
                    let playList = try DictionaryDecoder().decode(Playlists.self, from: playlist)
                    playlistLibraryVC.playlist = playList
                }
                catch let error {
                    print("Couldn't get in Playlist as", error.localizedDescription)
                }
                
                self.navigationController?.pushViewController(playlistLibraryVC, animated: true)
                break;
            case .failure(let error):
                print("Not created playlist Error ->", error.localizedDescription)
            }
        }
    }
    
    
}

// MARK: - Button Actions
extension YourLibraryVC {
    
    @IBAction func addPlaylistAction(_ sender: UIButton) {
        self.setUpFloatingForLabourFilter()
    }
    
    @IBAction func gridListAction(_ sender: UIButton) {
        self.menuListStyle = (self.menuListStyle == .GridView) ? .ListView : .GridView
       
    }
    
    @IBAction func recentAction(_ sender: UIButton) {
        
    }
}

extension YourLibraryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPlaylists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.menuListStyle {
        case .GridView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCVCell", for: indexPath) as! GridCVCell
            
            let playList = self.allPlaylists[indexPath.item]
            
            cell.imgPlaylist.loadImageFromProfile(urlString: playList.cover ?? "")
            cell.lblPlayList.text = playList.name ?? ""
            cell.lblTotalSongs.text = "Playlist • \(playList.songCount ?? 0) Songs"
            
            return cell
        case .ListView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCVCell", for: indexPath) as! ListCVCell
            
            let playList = self.allPlaylists[indexPath.item]
            
            cell.imgPlaylist.loadImageFromProfile(urlString: playList.cover ?? "")
            cell.lblPlayList.text = playList.name ?? ""
            cell.lblTotalSongs.text = "Playlist • \(playList.songCount ?? 0) Songs"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

