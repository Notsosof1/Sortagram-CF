
/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func uploadImageButton(sender: AnyObject) {
        
    }
    
    @IBAction func filterButtonPressed(sender: AnyObject) {
        presentFilterAlert()
        
    }
    
    func presentFilterAlert() {
        
        let alertController = UIAlertController(title: "FILTERS", message: "Pick One", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let VintageFilterAction = UIAlertAction(title: "Vintage", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                }
            })
        }
        
        let BWFilterAction = UIAlertAction(title: "Black and White", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyBWEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                }
            })
        }
        
        let ChromeFilterAction = UIAlertAction(title: "Black and White", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyChrome(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                    
                if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                    }
            })
        }
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alertController.addAction(VintageFilterAction)
            alertController.addAction(BWFilterAction)
            alertController.addAction(ChromeFilterAction)
            alertController.addAction(cancelAction)
        }

    
    @IBAction func buttonPressed(sender:UIButton!) {
        print("pressed")
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let alert = UIAlertController(title: "Please Select One", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.Camera)                
            }
            
            let photoLibrary = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.PhotoLibrary)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
                let alertController = UIAlertController(title: "CANCEL?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                
                let action = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                    print("Cancel")
                })
                
                alertController.addAction(action)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            alert.addAction(photoLibrary)
            alert.addAction(cameraAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            self.presentImagePicker(.PhotoLibrary)
            
        }
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
//
//        let imageFile = PFFile(name: "image", data: imageData)

        let status = PFObject(className: "Status")
        status[kStatusTextKey] = "Took this picture on my way to Code Fellows today."
        status["location"] = "Seattle"
        status["hashtages"] = "#seattle"
        
        status.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("succes saving to parse.   Check Parse console.")
                }
            }
        }
    }

