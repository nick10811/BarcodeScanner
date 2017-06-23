//
//  ViewController.swift
//  BarcodeScanner
//
//  Created by Nick Yang on 19/06/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarcodeScannerDelegate {

    @IBOutlet weak var resultOfBarcode_TextView: UITextView!
    
    @IBAction func ScanBarcode(_ sender: Any) {
        let barcodeViewController = BarcodeScannerViewController()
        barcodeViewController.delegate = self
        self.present(barcodeViewController, animated: true, completion: nil)
    }
    
    // MARK: - BarcodeScannerDelegate
    func barcodeScannerController(_ scanner: BarcodeScannerViewController, didFinishPickingBarcodeContent content: String) {
        resultOfBarcode_TextView.text = content
        
        scanner.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

