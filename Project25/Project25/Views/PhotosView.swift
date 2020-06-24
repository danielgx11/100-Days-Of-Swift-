//
//  PhotosView.swift
//  Project25
//
//  Created by Daniel Gx on 23/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class PhotosView: UICollectionViewController {
    
    // MARK: - Properties
    
    var images = [UIImage]()
    var texts = [String]()
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    // MARK: - Actions
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func importTxt() {
        let ac = UIAlertController(title: "Import Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [unowned ac, weak self] (_) in
            guard let text = ac.textFields?[0].text else { return }
            self?.texts.append(text)
        }))
    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showPeers() {
        var peersTxt = ""
        
        var peersAvailable = false
        
        guard let mcSession = mcSession else { return }
        
        if mcSession.connectedPeers.count > 0 {
            peersAvailable = true
            for peer in mcSession.connectedPeers {
                peersTxt += "\n\(peer.displayName)"
            }
        }
        
        if !peersAvailable {
            peersTxt += "\nNo peers connected!"
        }
        
        alertController(message: peersTxt)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        startMcSession()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        title = "Selfie Share"
        let sendImage = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        let sendTxt = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(importTxt))
        let session = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        let peers = UIBarButtonItem(title: "Peers", style: .done, target: self, action: #selector(showPeers))
        navigationItem.leftBarButtonItems = [session, peers]
        navigationItem.rightBarButtonItems = [sendImage, sendTxt]
    }
    
    func alertController(title: String = "Warning", message: String? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func sendTxt(_ text: String) {
        
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            let textData = Data(text.utf8)
            do {
                try mcSession.send(textData, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: "Send Error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                present(ac, animated: true, completion: nil)
            }
        }
        
    }
}

// MARK: - CollectionView Delegate

extension PhotosView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.row]
        }
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        guard let mcSession = mcSession else { return }
        
        if mcSession.connectedPeers.count > 0 {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send Error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(ac, animated: true, completion: nil)
                }
            }
        }
    }
    
}

// MARK: - MultipeerConnectivition Delegates

extension PhotosView: MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // nothing but required delegate method
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // nothing but required delegate method
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // nothing but required delegate method
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            }
            
            let text = String(decoding: data, as: UTF8.self)
            self?.texts.insert(text, at: 0)
            self?.collectionView.reloadData()
        }
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")

        case .connecting:
            print("Connecting: \(peerID.displayName)")

        case .notConnected:
            alertController(message: "\(peerID.displayName) was disconnected!")

        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    // MARK: - McSessions Methods
    
    func startMcSession() {
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true, completion: nil)
    }
}
