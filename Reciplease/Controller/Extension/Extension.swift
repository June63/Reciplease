//
//  Extension.swift
//  Reciplease
//
//  Created by Léa Kieffer on 13/12/2021.
//

import Foundation
import Alamofire

extension String {
    
    func split(regex pattern: String) -> [String] {
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
            else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
    
    func createString() -> String {
        let array = [String]()
        //let array = self
        let string = String()
        for i in 0..<array.count {
            var string = String()
            string += "\(array[i]),"
        }
        return string
    }
}

extension Array {
    func createString() -> String {
        let array = self
        var string = String()
        for i in 0..<array.count {
            string += "\(array[i]),"
        }
        return string
    }
}

extension UIViewController {
    // use case example : self.presentAlert(message: .errorIngredientneeded)
    func presentAlert(error: ErrorMessage) {
        let alertVC = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}

// use case example : recipeDetailImageView.downloaded(from: urlImage)
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        AF.request(url).responseData { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func cornerRadius(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
}

extension Int {
    func hour() -> String {
        let numberMin = self % 60
        let numberHour = self / 60
        if numberHour == 0 && numberMin == 0 {
            let string = "Na"
            return string
        }
        let timeString = String(format: "%01i:%02i", numberHour, numberMin)
        return timeString
    }
}

extension UIView {
    func transformateViewOnImage() -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let imgOriginal = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return imgOriginal
    }
}

extension UITableView {
    func setLoadingScreen(loadingView: UIView,spinner:UIActivityIndicatorView, loadingLabel: UILabel ) {
        
        let width: CGFloat = self.bounds.width
        let height: CGFloat = self.bounds.height
        let x: CGFloat = 0
        let y: CGFloat = 0
       
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        //loadingLabel.center = loadingView.center
        loadingLabel.frame = CGRect(x: 0, y: 0, width: loadingView.bounds.width, height: loadingView.bounds.height - 200)
        
        // Sets spinner
        spinner.style = .medium
        spinner.color = .gray
        spinner.frame = CGRect(x: -100, y: 0, width: loadingView.bounds.width, height: loadingView.bounds.height - 200)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
       //self.addSubview(loadingView)
        self.addSubview(loadingView)
    //self.backgroundView = loadingView
    }

    func removeLoadingScreen(loadingView: UIView,spinner:UIActivityIndicatorView, loadingLabel: UILabel) {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
        loadingView.removeFromSuperview()
    }

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.backgroundColor = UIColor(named: "Fond")
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

