//
//  CameraVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController, AVCapturePhotoCaptureDelegate {
    
    let cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let captureButton: CaptureButton = {
        let btn = CaptureButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        btn.addTarget(self, action: #selector(handleCaptering), for: .touchUpInside)
        return btn
    }()
    
    let output = AVCapturePhotoOutput()
    let captionSession = AVCaptureSession()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupUI()
    }
    
    @objc func handleCaptering() {
        print("taking photo from normalView")
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
        guard let image = UIImage(data: imageData)?.getInstagramImage(x: cameraView.frame.size.width, y: cameraView.frame.size.height, frame: cameraView.frame) else {return}
        let imageViewerVC = ImageViewerVC()
        imageViewerVC.image = image
        navigationController?.pushViewController(imageViewerVC, animated: true)
    }
    
    func setupCaptureSession() {
        output.isHighResolutionCaptureEnabled = true
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
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        DispatchQueue.main.async {
            previewLayer.frame = self.cameraView.bounds
            self.cameraView.layer.addSublayer(previewLayer)
            self.captionSession.startRunning()
        }
    }
    
}
