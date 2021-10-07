//
//  ClosureButton.swift
//
//  Created by Danish Khan on 14/12/20.
//

import Foundation
import UIKit

protocol ClosureButtonTargetViewDelegate:class {
    func closureButtonTargetView() -> UIView!
}

enum SelectedButton: Int {
    case assigned = 0
    case practice = 1
    case report = 2
}


class ClosureButton: UIButton {
    var row:Int?
    var section:Int?
    var type: SelectedButton?
    
    public typealias ButtonAction = (ClosureButton)->Void
    private var closureCallback:ButtonAction!
    
    var targetViewDelegate:ClosureButtonTargetViewDelegate!
    
    func setAction(controlEvents:UIControl.Event = UIControl.Event.touchUpInside,action:@escaping ButtonAction){
        self.closureCallback = action
        self.removeTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
        self.addTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
    }
   
    @objc private func actionPerformed() {
        self.closureCallback(self)
    }
    
    var targetView:UIView {
        get{
            if let view = targetViewDelegate.closureButtonTargetView() {
                return view
            }
            fatalError("implement the ClosureButtonTargetViewDelegate to the target view")
        }
    }
    
}



--------------- UITableViewCell

class AudioPlayerTableViewCell: UITableViewCell {
  
    @IBOutlet weak var audioPlayButton:ClosureButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func playButtonTapped(action:@escaping ClosureButton.ButtonAction) {
      self.audioPlayButton.setAction(action: action)
    }
}


--------------- CellForRowAt

 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
                cell.audioPlayButton.tag = indexPath.row
               
                cell.playButtonTapped { (playButton) in
                    let index = playButton.tag
                }
                return cell
 }


