//
//  NewContactViewController.swift
//  Homework_DanhBa
//
//  Created by Vu Nam Ha on 15/07/2022.
//

import UIKit

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var tenTextField: UITextField!
    @IBOutlet weak var hoTextField: UITextField!
    
    weak var delegate: DataDelegate?
    var detailHo: String = ""
    var detailTen: String = ""
    var prevScene: String = "root"
    var handlePassName: ((String, String) -> Void)?             // Closure để trả name đã edit về màn Detail
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactImage.layer.cornerRadius = contactImage.bounds.height/2
        title = "Liên hệ Mới"
        hoTextField.keyboardType = .default
        tenTextField.keyboardType = .default
        hoTextField.text = detailHo
        tenTextField.text = detailTen
        hoTextField.becomeFirstResponder()
    }
    
    @IBAction func actionHuy(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        if prevScene == "root" {                    // Nếu từ màn root present sang
        if let ho = hoTextField.text,
           let ten = tenTextField.text,
           ho.count > 0,
           ten.count > 0 {
            delegate?.passData(ho: ho, ten: ten)
            print(ho,ten)
            dismiss(animated: true)
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Nhập đầy đủ họ và tên", preferredStyle: .alert)
            let actionDone = UIAlertAction(title: "Ok", style: .default) { _ in
                print()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertVC.addAction(actionDone)
            alertVC.addAction(actionCancel)
            present(alertVC, animated: true)
        }
        } else {                                    // Nếu từ màn Detail Present sang để edit
            if hoTextField.text != detailHo || tenTextField.text != detailTen,
               hoTextField.text!.count > 0 ,
               tenTextField.text!.count > 0 {
                handlePassName?(hoTextField.text!, tenTextField.text!)
                dismiss(animated: true)
            }
        }
    }
    
}

protocol DataDelegate: AnyObject {
    func passData(ho: String, ten: String)
}
