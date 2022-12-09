//
//  Photo+CoreDataClass.swift
//  Photorama
//
//  Created by 이정민 on 2022/12/08.
//
//

import Foundation
import CoreData
import UIKit

public class Photo: NSManagedObject {
    var image: UIImage? // 코어에디터에 정의되지 않은 속성 정의
    
    //새로운 엔티티를 코어데이터에 저장하고자 하는 경우 가장 먼저 호출되는 함수
    //마치 생성자와 같은 역할을 한다.
    override public func awakeFromInsert() {
        title = ""
        photoID = ""
        photoKey = UUID().uuidString
        remoteURL = NSURL() as URL
        dateTaken = Date()
    }
}
