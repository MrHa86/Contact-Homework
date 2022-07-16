//
//  ViewController.swift
//  Homework_DanhBa
//
//  Created by Vu Nam Ha on 15/07/2022.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var arrName: [[String]] = [ ["An", "Hà Anh", "Ngọc Ân","Thùy Anh"],
                               ["Bình", "Bắc", "Xuân Bách"],
                               ["Cường", "Công Chính", "Chỉnh", "Châu"],
                               ["Dũng", "Thanh Dương", "Thành Đạt"] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configContactTableView()
        title = "Liên hệ"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAddButton))            // nút add
        navigationItem.rightBarButtonItems = [ addButton]
    }

    @objc func actionAddButton() {
        let newContactVC = NewContactViewController()
        newContactVC.delegate = self
        newContactVC.prevScene = "root"
        present(newContactVC, animated: true)
    }
    func setUpUI() {
        searchTextField.layer.cornerRadius = 10
    }
    
    func configContactTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
    
    }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("number of section = \(arrName.count)")
        return arrName.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName[section].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(arrName[indexPath.section][indexPath.row])"
        cell.textLabel?.font = .boldSystemFont(ofSize: 19)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        default:
            return "D"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()           // chuyển sang màn Detail
        detailVC.hoten = "\(arrName[indexPath.section][indexPath.row])"
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.arrName.remove(at: [indexPath.section][indexPath.row])
            self.contactTableView.reloadData()
        }
        deleteButton.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
}

extension ViewController: DataDelegate {
    func passData(ho: String, ten: String) {
        
        switch ten[ten.startIndex] {
        case "A", "a":
            arrName[0].append("\(ho) \(ten)")
        case "B", "b":
            arrName[1].append("\(ho) \(ten)")
        case "C", "c":
            arrName[2].append("\(ho) \(ten)")
        default:
            arrName[3].append("\(ho) \(ten)")
            
        }
        
        contactTableView.reloadData()
    }
    
    
}
