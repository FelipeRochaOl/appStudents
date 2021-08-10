//
//  ViewController.swift
//  students
//
//  Created by Felipe Rocha Oliveira on 09/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var studentsTableView: UITableView!
    
    var peoples: [People] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentsTableView.delegate = self
        self.studentsTableView.dataSource = self
        
        //register CustomCell
        self.studentsTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        //remove white rows
        self.studentsTableView.tableFooterView = UIView()

        self.peoples = self.factoryStudents(15)
    }
    
    func factoryStudents(_ qty: Int) -> [People] {
        var cont: Int = 0
        var arrStudents: [People] = []
        
        while cont <= qty {
            let getGenero: Genero = cont%2==0 ? .man : .woman
            arrStudents.append(People.init(name: "Student Name \(cont)", lastname: "Lastname\(cont)", age: Int.random(in: 18...70), email: "email\(cont)@test.com", genero: getGenero, avatar: "image\(Int.random(in: 1...7)).png" ))
            cont += 1
        }
        
        return arrStudents
    }

}

// MARK: - UiTableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Students"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell? = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell

        cell?.nameLabel.text = self.peoples[indexPath.row].name
        cell?.lastnameLabel.text = self.peoples[indexPath.row].lastname
        cell?.avatarImageView.image = UIImage(named: self.peoples[indexPath.row].avatar ?? "user.png")
        
        return cell ?? UITableViewCell()
    }
}
