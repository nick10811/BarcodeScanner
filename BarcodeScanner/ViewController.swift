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
        barcodeViewController.cancelButton_Text = "取消" // customize text of cancel button, default text is "Cancel"
        barcodeViewController.delegate = self
        self.present(barcodeViewController, animated: true, completion: nil)
    }
    
    // MARK: - BarcodeScannerDelegate
    func barcodeScannerController(_ scanner: BarcodeScannerViewController, didFinishPickingBarcodeContent content: String?) {
        resultOfBarcode_TextView.text = content ?? "" // BarcodeScanner returns String let you to do what you want
        
        scanner.dismiss(animated: true) // remember to dismiss the Barcode ViewController
        
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

