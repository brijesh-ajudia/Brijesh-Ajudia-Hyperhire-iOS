//
//  SearchSongVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

class SearchSongVC: BaseViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var tblSongs: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTableData()
    }
    

    func setUpTableData() {
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTVCell", for: indexPath) as! PlaylistTVCell
        
        cell.imgCover.cornerRadiuss = 26.0
        cell.btnMore.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 + 16
    }
    
    
}
