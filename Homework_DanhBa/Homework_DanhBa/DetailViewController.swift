//
//  DetailViewController.swift
//  Homework_DanhBa
//
//  Created by Vu Nam Ha on 15/07/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UILabel!
    var hoten:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = hoten
        
        let editContactButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
        navigationItem.rightBarButtonItems = [ editContactButton]
    }
    
    @objc func actionEdit() {
        let newContactVC = NewContactViewController()
        let arrHoTen: [String] = hoten.components(separatedBy: " ")
        newContactVC.detailHo = arrHoTen.first ?? ""
        newContactVC.detailTen = arrHoTen.last ?? ""
        newContactVC.prevScene = "detail"
        
        newContactVC.handlePassName = {ho,ten in
            self.nameTextField.text = "\(ho) \(ten)"
            
        }
        present(newContactVC, animated: true)
    }
    
    
    
    
}
