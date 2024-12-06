//
//  CreatPlaylistVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

protocol CreatPlaylistDelagate {
    func createdPlaylist(name: String)
}

class CreatPlaylistVC: BaseViewController {
    
    @IBOutlet weak var txtPlaylist: UITextField!
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    var delegate: CreatPlaylistDelagate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTxtFieldData()
    }
    
    // MARK: - Navigation
    func setUpTxtFieldData() {
        self.txtPlaylist.tag = 0
        self.txtPlaylist.delegate = self
        self.txtPlaylist.keyboardType = .default
        self.txtPlaylist.setAttributesPlaceHolder_Color(placeHolderString: "Enter playlist name")
        self.txtPlaylist.keyboardAppearance = .dark
        self.txtPlaylist.returnKeyType = .done
        self.txtPlaylist.addTarget(self, action: #selector(nameValidate), for: .editingChanged)
        
        self.btnConfirm.configuration?.background.backgroundColor = .A_9_A_9_A_9
        self.btnConfirm.isUserInteractionEnabled = false
    }

}

//MARK: - TextField Delegate Methods
extension CreatPlaylistVC {
    
    @objc func nameValidate() {
        let nameCount = self.txtPlaylist.text?.count ?? 0
        
        if nameCount == 0 {
            self.btnConfirm.configuration?.background.backgroundColor = .A_9_A_9_A_9
            self.btnConfirm.isUserInteractionEnabled = false
        }
        else {
            self.btnConfirm.configuration?.background.backgroundColor = ._1_ED_760
            self.btnConfirm.isUserInteractionEnabled = true
        }
     }
    
}

//MARK: - Button Action
extension CreatPlaylistVC {
    
    @IBAction func confirmAction(_ sender: UIButton) {
        self.delegate?.createdPlaylist(name: self.txtPlaylist.text?.trim() ?? "")
        self.dismiss(animated: true)
    }
}

