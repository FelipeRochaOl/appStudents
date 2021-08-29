//
//  DetailViewController.swift
//  students
//
//  Created by Felipe Rocha Oliveira on 10/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    
    var selectedPeople: People?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //receive data in DetailViewController
        self.avatarImageView.image = UIImage(named: self.selectedPeople?.avatar ?? "user.png")
        self.nameLabel.text = "name: \(self.selectedPeople?.name ?? "")"
        self.lastLabel.text = "lastname: \(self.selectedPeople?.lastname ?? "")"
        self.ageLabel.text = "age: \(String(self.selectedPeople?.age ?? 0))"
        self.emailLabel.text = "email: \(self.selectedPeople?.email ?? "")"
        self.generoLabel.text = "genero: \(self.selectedPeople?.genero?.rawValue ?? "")"
    }
}
