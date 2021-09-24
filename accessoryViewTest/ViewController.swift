//
//  ViewController.swift
//  accessoryViewTest
//
//  Created by Thisura Dodangoda on 2021-09-24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private var confirmButtonBottomConstrains: NSLayoutConstraint!
    @IBOutlet private weak var othersTextField: UITextField!
    
    private weak var accessory: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToShowKeyboardNotifications()
        confirmButtonUI()
        setupInputAccessory()
        
        othersTextField.delegate = self
    }
    
    func setupInputAccessory(){
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44.0)
        let btn = UIButton(frame: frame)
        
        btn.backgroundColor = UIColor.purple
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Confirm", for: .normal)
        btn.addTarget(self, action: #selector(accessoryConfirmTapped), for: .touchUpInside)
        
        othersTextField.inputAccessoryView = btn
        
        self.accessory = btn
        self.accessory?.isHidden = true
    }
    
    func confirmButtonUI() {
        confirmButton.layer.cornerRadius = 20.0
        confirmButton.layer.shadowRadius = 1.0
        confirmButton.layer.shadowColor = UIColor(displayP3Red: 33/255, green: 68/255, blue: 27/255, alpha: 0.18).cgColor
        confirmButton.layer.backgroundColor = UIColor(displayP3Red: 164/255, green: 208/255, blue: 208/255, alpha: 1).cgColor
        confirmButton.isEnabled = false
        confirmButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        confirmButton.layer.shadowOpacity = 1.0
        confirmButton.layer.masksToBounds = false
    }

    func subscribeToShowKeyboardNotifications() {

       NotificationCenter.default.addObserver(self, selector:
       #selector(keyboardWillShow(_:)), name:
       UIResponder.keyboardWillShowNotification, object: nil)
      
       NotificationCenter.default.addObserver(self, selector:
       #selector(keyboardWillHide(_:)), name:
       UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func accessoryConfirmTapped(){
        othersTextField.resignFirstResponder()
    }

     @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        confirmButton.isHidden = true
        accessory?.isHidden = false

        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        _ = keyboardSize.cgRectValue.height
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }



    @objc func keyboardWillHide(_ notification: Notification) {
        confirmButton.isHidden = false
        accessory?.isHidden = true
        
        let userInfo = notification.userInfo
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
