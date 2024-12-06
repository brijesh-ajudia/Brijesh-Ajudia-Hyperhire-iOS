//
//  YourLibraryVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

class YourLibraryVC: UIViewController {
    
    @IBOutlet weak var clvList: UICollectionView!
    
    //var allLibrary: [LibraryItem] = []
    
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

// MARK: - Button Actions
extension YourLibraryVC {
    
    @IBAction func gridListAction(_ sender: UIButton) {
        self.menuListStyle = (self.menuListStyle == .GridView) ? .ListView : .GridView
       
    }
    
    @IBAction func recentAction(_ sender: UIButton) {
        
    }
}

extension YourLibraryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.menuListStyle {
        case .GridView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCVCell", for: indexPath) as! GridCVCell
            
            cell.lblPlayList.text = "Playlist"
            cell.lblTotalSongs.text = "• 220 Songs"
            
            return cell
        case .ListView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCVCell", for: indexPath) as! ListCVCell
            
            cell.lblPlayList.text = "Playlist"
            cell.lblTotalSongs.text = "• 220 Songs"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

