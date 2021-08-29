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
        
        // register CustomCell
        self.studentsTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        // remove white rows
        self.studentsTableView.tableFooterView = UIView()

        self.peoples = self.factoryStudents(15)
    }
    
    // factory create dynamic students
    func factoryStudents(_ qty: Int) -> [People] {
        var cont: Int = 0
        var arrStudents: [People] = []
        
        while cont <= qty {
            let getGenero: Genero = cont%2==0 ? .man : .woman
            arrStudents.append(People.init(name: "Student Name \(cont)", lastname: "Lastname\(cont)", age: Int.random(in: 18...70), email: "email\(cont)@test.com", genero: getGenero, avatar: "image\(Int.random(in: 1...7)).png", customID: cont))
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

        cell?.setup(object: self.peoples[indexPath.row])
        cell?.delegate = self
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeople: People = self.peoples[indexPath.row]
        
        // invite info to next view
        performSegue(withIdentifier: "DetailViewController", sender: selectedPeople)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepare object before renderize next view
        if segue.identifier == "EditViewController" {
            let _editViewController: EditViewController? = segue.destination as? EditViewController
            _editViewController?.selectedPeople = sender as? People
            
            _editViewController?.delegate = self
        } else {
            // segue.destination return instance the view and not the class
            let _detailViewController: DetailViewController? = segue.destination as? DetailViewController
            _detailViewController?.selectedPeople = sender as? People
        }
    }
}

// MARK: - CustomCellProtocol
extension ViewController: CustomCellProtocol {
    func editButton(value: People) {
        print("ViewController=====>CustomCell.editButton====>observable protocol\(value)")
        // This is a dispatch function prepare
        self.performSegue(withIdentifier: "EditViewController", sender: value)
    }
}

// MARK: - EditViewController
extension ViewController: EditViewControllerProtocol {
    func updatePeople() {
        // people is in reference to memory, change in editView reflect in ViewController
        // self.peoples.filter({$0.customID != value.customID})
        // self.peoples.append(value)
        self.studentsTableView.reloadData()
    }
}
