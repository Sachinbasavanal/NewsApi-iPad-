//
//  UIImage+Download+Extension.swift
//  Assignment4
//
//  Created by M1066966 on 30/08/21.
//

import UIKit

extension UIImageView{
    func loadImage(url:URL)->URLSessionDownloadTask{
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){localURL,_,error in
            if error == nil,let url = localURL,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
