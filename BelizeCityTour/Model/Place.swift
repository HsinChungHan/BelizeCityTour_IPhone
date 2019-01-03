//
//  Restaurant.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import Foundation
import UIKit

public struct Place{
    
    let tag: Int, englishName: String, mandarinName: String, address: String, coordinate: (latitude: CGFloat, longitude: CGFloat), type: String, phone: String, openingTime: String, imgs: [String],englishStorys: [String], englishStory: String, englishStoryFirst: String, englishStorySecond: String, englishStoryThird: String, mandarinStory: String, mandarinStoryFirst: String, mandarinStorySecond: String, mandarinStoryThird: String, mapImg: String,iconImg: String, website: String, iconLocation: (x: CGFloat, y: CGFloat)
    
    var isLiked: Bool
    
    init(dict: [String : Any]) {
        self.tag = dict[BelizeCultureJSONConstant.tag.rawValue] as? Int ?? 0
        self.englishName = dict[BelizeCultureJSONConstant.englishName.rawValue] as? String ?? ""
        self.mandarinName = dict[BelizeCultureJSONConstant.mandarinName.rawValue] as? String ?? ""
        self.address = dict[BelizeCultureJSONConstant.address.rawValue] as? String ?? ""
        self.coordinate.latitude = dict[BelizeCultureJSONConstant.latitude.rawValue] as? CGFloat ?? 0
        self.coordinate.longitude = dict[BelizeCultureJSONConstant.longitude.rawValue] as? CGFloat ?? 0
        self.type = dict[BelizeCultureJSONConstant.type.rawValue] as? String ?? ""
        self.openingTime = dict[BelizeCultureJSONConstant.openingTime.rawValue] as? String ?? ""
        self.imgs = dict[BelizeCultureJSONConstant.imgs.rawValue] as? [String] ?? [String]()
        self.englishStorys = dict[BelizeCultureJSONConstant.englishStorys.rawValue] as? [String] ?? [String]()
        self.englishStory = dict[BelizeCultureJSONConstant.englishStory.rawValue] as? String ?? ""
        self.englishStoryFirst = dict[BelizeCultureJSONConstant.englishStoryFirst.rawValue] as? String ?? ""
        self.englishStorySecond = dict[BelizeCultureJSONConstant.englishStorySecond.rawValue] as? String ?? ""
        self.englishStoryThird = dict[BelizeCultureJSONConstant.englishStoryThird.rawValue] as? String ?? ""
        self.mandarinStory = dict[BelizeCultureJSONConstant.mandarinStory.rawValue] as? String ?? ""
        self.mandarinStoryFirst = dict[BelizeCultureJSONConstant.mandarinStoryFirst.rawValue] as? String ?? ""
        self.mandarinStorySecond = dict[BelizeCultureJSONConstant.mandarinStorySecond.rawValue] as? String ?? ""
        self.mandarinStoryThird = dict[BelizeCultureJSONConstant.mandarinStoryThird.rawValue] as? String ?? ""
        self.mapImg = dict[BelizeCultureJSONConstant.mapImg.rawValue] as? String ?? ""
        self.iconImg = dict[BelizeCultureJSONConstant.iconImg.rawValue] as? String ?? ""
        self.website = dict[BelizeCultureJSONConstant.website.rawValue] as? String ?? ""
        self.iconLocation.x = dict[BelizeCultureJSONConstant.iconLocationX.rawValue] as? CGFloat ?? 0
        self.iconLocation.y = dict[BelizeCultureJSONConstant.iconLocationY.rawValue] as? CGFloat ?? 0
        self.isLiked = dict[BelizeCultureJSONConstant.isLiked.rawValue] as? Bool ?? false
        self.phone = dict[BelizeCultureJSONConstant.phone.rawValue] as? String ?? ""
        
    }
    
    
    
    static func getPlaces() -> [Place]{
        var places = [Place]()
        parseJSON(fileName: "AllPlaces") { (arr) in
            for dict in arr{
                let place = Place(dict: dict as! [String : Any])
                places.append(place)
            }
        }
        return places
    }
    
}

func parseJSON(fileName: String?, completion: (_ jsonArr: NSArray) -> ()) {
    let path = Bundle.main.path(forResource: fileName , ofType: "json")
    let url = URL(fileURLWithPath: path!)
    do {
        let data = try Data(contentsOf: url)
        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonArr = jsonData as! NSArray
        completion(jsonArr)
    } catch let error {
        print("Failed to access local JSON file",error)
    }
}
