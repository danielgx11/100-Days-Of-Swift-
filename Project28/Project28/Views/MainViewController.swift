//
//  MainViewController.swift
//  Project28
//
//  Created by Daniel Gx on 06/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var secret: UITextView!
    private var passwordKey = "admin"
    
    // MARK: - Actions
    
    @IBAction func AuthenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, authenticationError) in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if success {
                        self.enablePassword()
                        self.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Password", message: nil, preferredStyle: .alert)
                        ac.addTextField()
                        let submitAction = UIAlertAction(title: "Done", style: .default) { [unowned ac] (_) in
                            guard let password = ac.textFields?[0].text else { return }
                            
                            self.authenticationWithPassword(password)
                        }
                        ac.addAction(submitAction)
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
                
        title = "Nothing to see here"
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc func saveSecretPassword(_ password: String) {
        KeychainWrapper.standard.set(password, forKey: "SecretPassword")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        notificationCenterObserver()
    }
    
    // MARK: - Methods
    
    func enablePassword() {
        let ac = UIAlertController(title: "Password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Done", style: .default) { [unowned ac] (_) in
            guard let password = ac.textFields?[0].text else { return }
            
            KeychainWrapper.standard.set(password, forKey: "SecretPassword")
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func authenticationWithPassword(_ password: String) {
        guard let oldKey = KeychainWrapper.standard.string(forKey: "SecretPassword") else { return }
        
        if password == oldKey {
            unlockSecretMessage()
        } else {
            let ac = UIAlertController(title: "Authentication Failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func customizeNavigationController() {
        title = "Nothing to see here"
    }
    
    func notificationCenterObserver() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        
        activateDoneButton()
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    func activateDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
    }
}
