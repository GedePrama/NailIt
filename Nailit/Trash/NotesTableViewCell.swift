//
//  NotesTableViewCell.swift
//  Nailit
//
//  Created by Gede Wicaksana on 13/04/21.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var notesTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
