//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by 陈琪 on 12/10/15.
//  Copyright © 2015 陈琪. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}