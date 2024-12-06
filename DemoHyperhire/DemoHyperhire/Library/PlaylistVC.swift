//
//  PlaylistVC.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

protocol PlaylistDelagate {
    func filterLabour(isClicked: Bool)
}

class PlaylistVC: UIViewController {
    
    var delegate: PlaylistDelagate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





//MARK: - Button Actions
extension PlaylistVC {
    
    @IBAction func createPlaylistAction(_ sender: UIButton) {
        self.delegate?.filterLabour(isClicked: true)
    }
}
