//
//  FullCameraVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import AVFoundation

class FullCameraVC: UIViewController {
    
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCaptureSession()
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
        let output = AVCapturePhotoOutput()
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
        print("taking photo from normalView")
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
