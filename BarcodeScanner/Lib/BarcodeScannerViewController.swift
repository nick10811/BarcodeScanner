//
//  BarcodeScannerViewController.swift
//  BarcodeScanner
//
//  Created by Nick Yang on 19/06/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//
//  https://github.com/nick10811/BarcodeScanner
//

import UIKit
import AVFoundation

@available(iOS 8.0, *)
@objc public protocol BarcodeScannerDelegate {
    func barcodeScannerController(_ scanner: BarcodeScannerViewController, didFinishPickingBarcodeContent content: String)
}

@available(iOS 8.0, *)
public class BarcodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var delegate: BarcodeScannerDelegate?
    var cancelButton_Text = "Cancel"
    
    var captureSession:AVCaptureSession?
    var captureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    func stopRunning() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // get QR code contents
        var result:String?
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            result = metadataObj.stringValue
        }
        delegate?.barcodeScannerController(self, didFinishPickingBarcodeContent: result!)
        
    }
    
    // MARK: - UIView
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        // MARK: configure camera
        try! captureDevice!.lockForConfiguration()
        
        // continuous autofocus
        if captureDevice!.isFocusModeSupported(.autoFocus) {
            captureDevice!.focusPointOfInterest = CGPoint(x:0.5, y:0.5)
            captureDevice!.focusMode = .continuousAutoFocus
        }
        
        captureDevice!.unlockForConfiguration()
        
        let input = try? AVCaptureDeviceInput.init(device: captureDevice)
        captureSession = AVCaptureSession()
        captureSession!.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        captureSession!.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeDataMatrixCode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode]
        
        captureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
        captureVideoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureVideoPreviewLayer!.connection.videoOrientation = .portrait
        self.view.layer.addSublayer(captureVideoPreviewLayer!)
        
        
        // tab bar view
        let tabView = UIView()
        tabView.frame = CGRect.init(x: 0, y: self.view.frame.height-60, width: self.view.frame.width, height: 60)
        tabView.backgroundColor = UIColor.black
        
        // Cancel Button
        let cancel_Button = UIButton()
        cancel_Button.frame = CGRect.init(x: 5, y: 5, width: 100, height: 50)
        cancel_Button.setTitle(cancelButton_Text, for: .normal)
        cancel_Button.setTitleColor(.white, for: .normal)
        cancel_Button.addTarget(self, action: #selector(self.stopRunning), for: .touchUpInside)
        
        tabView.addSubview(cancel_Button)
        self.view.addSubview(tabView)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession!.startRunning()
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        UIViewController.attemptRotationToDeviceOrientation()
        captureVideoPreviewLayer!.frame = self.view.bounds
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        captureSession!.stopRunning()
    }
    
    override open var shouldAutorotate: Bool {
        get { return false }
    }
    
    // force use portrait screen
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get { return .portrait }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
