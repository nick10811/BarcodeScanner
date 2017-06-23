# BarcodeScanner

BarcodeScanner is an open source project which let you easy to get barcode contents. 

## Supported Types
* UPC CODE
* EAN CODE (EAN-13, EAN-8)
* CODE 39
* CODE 128
* ITF (Interleaved 2 OF 5)
* CODE 93
* QR CODE
* DATAMATRIX CODE
* PDF417
* AZTEC

## Installation
* You can also download the Barcode.swift file into your project directly.

## How to use
To use this library in your project is very easy. BarcodeScanner is a ViewController so that you just `present` a ViewController to launch it and use `dismiss` to close it.

* Inital this object and assign delegate
```swift
let barcodeViewController = BarcodeScannerViewController()
barcodeViewController.delegate = self
```

* Launch camera to scan barcode in your ViewController
```swift
self.present(barcodeViewController, animated: true, completion: nil)
```

* You should adopt BarcodeSacnnerDelegate protocol and implemnt that method in your ViewController. The result from BarcodeScanner will use callback method let you get.
```swift
class ViewController: UIViewController, BarcodeScannerDelegate {
...
    // MARK: - BarcodeScannerDelegate
    func barcodeScannerController(_ scanner: BarcodeScannerViewController, didFinishPickingBarcodeContent content: String) {
        var result = content // BarcodeScanner returns String let you to do what you want
        scanner.dismiss(animated: true) // remember to dismiss the Barcode ViewController
    }

}
```

## Author
Nick Yang ([Profile](http://imjustaprogrammer.blogspot.com/))