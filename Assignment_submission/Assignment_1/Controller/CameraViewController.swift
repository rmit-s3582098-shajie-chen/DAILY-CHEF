//
//  CameraViewController.swift
//  Assignment_1
//
//  Created by Shajie Chen on 2/2/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
import AVKit;
import AVFoundation;
import MobileCoreServices;

@objc protocol CameraViewControllerDelegate:NSObjectProtocol {
    @objc optional func cameraViewConformClick(image:UIImage?)
}

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    @IBOutlet weak var confirm: UIButton!
    weak var delegate:CameraViewControllerDelegate?
    
    // AVKit
    var avPlayerViewController: AVPlayerViewController!
    var image: UIImage?
    var movieURL: URL?
    var lastChosenMediaType: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // If the camera source (i.e. simulator) is not available, then
        // hide the take picture button.
        if !UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            takePictureButton.isHidden = true
        }
        
        
        self.confirm.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
    }

    @objc func confirmClick() -> Void {
        print("confirmClick")
        if((self.delegate) != nil){
            self.delegate?.cameraViewConformClick!(image: self.imageView.image)
            self.dismiss(animated: true, completion: nil)
        }
    }
    // When returning to the app, update the display with the
    // chosen media type
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shootPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.camera)
    }
    
    @IBAction func selectExistingPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
   
    func updateDisplay() {
        
        // optional, so if let used to unwrap.
        if let mediaType = lastChosenMediaType {
            
            // if the media chosen is an image, then get the
            // image and display it.
            
            // MobileCore Services Package
            if mediaType == (kUTTypeImage as NSString) as String {
                imageView.image = image!
                imageView.isHidden = false
                if avPlayerViewController != nil {
                    avPlayerViewController!.view.isHidden = true
                }
                
                // Otherwise the media chosen is a video
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                if avPlayerViewController == nil {
                    // Instantiate a view for displaying the video
                    avPlayerViewController = AVPlayerViewController()
                    let avPlayerView = avPlayerViewController!.view
                    avPlayerView?.frame = imageView.frame
                    avPlayerView?.clipsToBounds = true
                    view.addSubview(avPlayerView!)
                }
                
                if let url = movieURL {
                    imageView.isHidden = true
                    avPlayerViewController.player = AVPlayer(url: url)
                    avPlayerViewController!.view.isHidden = false
                    avPlayerViewController!.player!.play()
                }
            }
        }
    }
    // This method gets called by the action methods to select
    // what type of media the user wants.
    func pickMediaFromSource(_ sourceType:UIImagePickerControllerSourceType) {
        
        // What media types are available on the device
        let mediaTypes =
            UIImagePickerController.availableMediaTypes(for: sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
            && mediaTypes.count > 0 {
            let picker = UIImagePickerController()
            // Display the media types avaialble on the picker
            picker.mediaTypes = mediaTypes
            
            // Set delegate to self for system method calls.
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            
            // Present the picker to the user.
            present(picker, animated: true, completion: nil)
        }
            // Otherwise display an error message
        else
        {
            let alertController = UIAlertController(title:"Error accessing media",
                                                    message: "Unsupported media source.",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    // Delegate method to process once the media has been selected
    // by the user.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? String
        
        // Set the variable to the data retrieved.
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                movieURL = info[UIImagePickerControllerMediaURL] as? URL
            }
        }
        
        // Dismiss the picker to return to the apps view
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
    
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        self.dismiss(animated: true, completion: nil)
    }
    

}
