//
//  CustomCell.swift
//  students
//
//  Created by Felipe Rocha Oliveira on 09/08/21.
//

import UIKit

protocol CustomCellProtocol: AnyObject {
    func editButton(value: People)
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    private var people: People?
    
    //weak reference memory
    weak var delegate: CustomCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        //Important: Only class type controller can call perform segue (protocol)
        if let _people: People = self.people {
            print("action editButton")
            self.delegate?.editButton(value: _people)
        }
    }

    func setup(object: People) {
        self.people = object
        self.nameLabel.text = object.name
        self.lastnameLabel.text = object.lastname
        self.avatarImageView.image = UIImage(named: object.avatar ?? "user.png")
    }
    
}
