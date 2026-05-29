//
//  ViewController.swift
//  Kedi ve Köpek
//
//  Created by Fırat İlhan on 3.04.2025.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)

    }
    
    // Resim seçildiğinde çağrılır
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let userPickedImage = info[.originalImage] as? UIImage {
                imageView.image = userPickedImage
                classifyImage(image: userPickedImage)
            }

            imagePicker.dismiss(animated: true)
        }

    func classifyImage(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            showAlert(message: "Error in CIImage conversion!")
            return
        }
        
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: CatDogClassifier(configuration: config).model) else {
            showAlert(message: "Model could not be loaded.")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                return
            }
            
            DispatchQueue.main.async {
                self?.title = "Prediction: \(topResult.identifier) (%\(Int(topResult.confidence * 100)))"
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try handler.perform([request])
        } catch {
            showAlert(message: "Classification failed.")
        }
    }
    
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

