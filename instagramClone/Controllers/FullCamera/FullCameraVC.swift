//
//  FullCameraVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class FullCameraVC: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate, AnimationTypeProtocol {
    
    let captureButton: CaptureButton = {
        let btn = CaptureButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        btn.addTarget(self, action: #selector(handleCaptering), for: .touchUpInside)
        return btn
    }()
    
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "right_arrow_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    let output = AVCapturePhotoOutput()
    var isMain: Bool = false
    var slidingAnimation = SlidingAnimation()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        setupCaptureSession()
        setupUI()
    }
    
    func setupCaptureSession() {
        let captionSession = AVCaptureSession()
        
        // 1. setup input
        let captureDevice = AVCaptureDevice.default(for: .video)
        do {
            if let capture = captureDevice {
                let input = try AVCaptureDeviceInput(device: capture)
                if captionSession.canAddInput(input) {
                    captionSession.addInput(input)
                }
            }
        } catch let err {
            print("couldn't use camera", err)
        }
        
        // 2. setup output
        if captionSession.canAddOutput(output) {
            captionSession.addOutput(output)
        }
        
        // 3. setup output preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captionSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        captionSession.startRunning()
    }
    
    @objc func handleCaptering() {
        let setting = AVCapturePhotoSettings()
        guard let previewPhoto = setting.availablePreviewPhotoPixelFormatTypes.first else {return}
        setting.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPhoto]
        output.capturePhoto(with: setting, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let err = error {
            print(err, "error")
            return
        }
        guard let imageData = photo.fileDataRepresentation() else { return }
        // needs debug
        guard let image = UIImage(data: imageData) else {return}
        convertView(image: image)
    }
    
    func convertView(image: UIImage) {
        let containerView = PreviewPhotoContainer()
        containerView.saveImage = self
        containerView.image = image
        view.addSubview(containerView)
        containerView.anchor(leading: view.leadingAnchor, top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}


//MARK:- Conforms to the saveImage taken protocol that takes the image from the presenter and saves it
// and creates the label to actually state it's saved
extension FullCameraVC: SaveImageTaken {

    func save(image: UIImage) {
        print("Saving from fullController")
        let library = PHPhotoLibrary.shared()
        
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (isSuccess, err) in
            if let err = err {
                print("failed to save", err)
                return
            }
            print(isSuccess, "to library")
            DispatchQueue.main.async {
                self.showSuccessSave()
            }
        }
    }
    
    func showSuccessSave() {
        let saveLabel = UILabel()
        saveLabel.text = "Saved Successfully :)"
        saveLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        saveLabel.font = UIFont.boldSystemFont(ofSize: 18)
        saveLabel.textColor = .white
        saveLabel.textAlignment = .center
        saveLabel.numberOfLines = 0
        saveLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
        saveLabel.center = self.view.center
        self.view.addSubview(saveLabel)
        
        saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                saveLabel.alpha = 0
            }) { (isDone) in
                saveLabel.removeFromSuperview()
            }
        }
        
    }
}
