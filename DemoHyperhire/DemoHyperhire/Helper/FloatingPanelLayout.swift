//
//  FloatingPanelLayout.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import Foundation
import FloatingPanel

class SetUpPlaylist: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: DeviceUtility.deviceHasTopNotch == false ? 0.13 : 0.09, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.6
    }
}

class defaultSelectionView: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.6
    }
}
