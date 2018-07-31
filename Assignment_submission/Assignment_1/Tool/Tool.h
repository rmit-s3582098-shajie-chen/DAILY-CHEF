//
//  Tool-ForLoacalImage.h
//  Assignment_1
//
//  Created by Shajie Chen on 1/30/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

#ifndef Tool_ForLoacalImage_h
#define Tool_ForLoacalImage_h


#endif /* Tool_ForLoacalImage_h */

var documentsUrl: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
private func save(image: UIImage) -> String? {
    let fileName = "FileName"
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    if let imageData = UIImageJPEGRepresentation(image, 1.0) {
        try? imageData.write(to: fileURL, options: .atomic)
        return fileName // ----> Save fileName
    }
    print("Error saving image")
    return nil
    }
private func load(fileName: String) -> UIImage? {
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    do {
        let imageData = try Data(contentsOf: fileURL)
        return UIImage(data: imageData)
    } catch {
        print("Error loading image : \(error)")
    }
    return nil
    }
