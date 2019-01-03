//
//  ProjuctIntroduction.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
enum ProjectIntroductionContent: CaseIterable {
    case first
    case second
    case third
    case fourth
    
    func introduction() -> (title: String, paragraphText: String, image: UIImage){
        switch self {
        case .first:
            return (title: "Belize City House of Culture and Downtown Rejuvenation Project", paragraphText: "    Belize City was the capital of Belize during the English colonial era. Strolling through its downtown area, you would come across some colonial-style old houses here and there. The city is like a treasure trove of Belizean history and culture that has long been forgotten.As a result, the Government of Belize has been working in collaboration with the TaiwanICDF since 2014 on developing the Downtown of Belize City into a rich eco-museum, composed of a selection of historical buildings such as the famous Government House and St. John’s Cathedral.", image: UIImage(named: "bg1")!)
        case .second:
            return (title: "Belize City House of Culture and Downtown Rejuvenation Project", paragraphText: "    We believe that by means of preserving and revitalizing the colonial-style public architecture and private houses, creating cultural amenities for community participation, and enhancing the tourist-friendly atmosphere, the old city can be most effectively transformed. We welcome you to join our journey and set out on a walking tour around. You’ll definitely be fascinated by the abundance of cultural heritage embedded in the city! ", image: UIImage(named: "bg2")!)
        case .third:
            return (title: "A vision of an eco-museum", paragraphText: "    In contrast to a conventional museum which emphasizes collecting objects and displaying them in one building, an eco-museum leaves objects in their current context. It could encompass a series of display nodes, architecture and landscapes which form a network where the local community members could work with museum specialists to present their history. ", image: UIImage(named: "bg3")!)
        case .fourth:
            return (title: "A vision of an eco-museum",  paragraphText: "    Therefore, an eco-museum could physically consist of a core and its satellites. The core museum possesses the unique contents which render the overall story of the city, while the satellites, according to their individual characteristics, are displayed with thematic subjects, cultural artifacts and people’s memories.In the case of Belize City, the former Government House, currently under renovation, will be repositioned as the core museum, connected by several rejuvenated satellites scattered within the Downtown of Belize City, forming an eco-museum that welcomes the visitors to discover the rich history and culture of Belize. ", image: UIImage(named: "bg4")!)
            
        }
    }
}


struct ProjectIntroduction {
    let title: String, paragraphText: String, image: UIImage
    static func getAllIntroductions() -> [ProjectIntroduction]{
        var projectIntroductions = [ProjectIntroduction]()
        for introduction in ProjectIntroductionContent.allCases{
            projectIntroductions.append(ProjectIntroduction(title: introduction.introduction().title, paragraphText: introduction.introduction().paragraphText, image: introduction.introduction().image))
        }
       return projectIntroductions
    }
}
