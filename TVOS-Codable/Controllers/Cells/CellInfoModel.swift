//
//  CellInfoModel.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

//MARK: - FTCellInfoModel
class CellInfoModel {
    var isLive:Bool = false
    var title:String?
    var contentType:ContentType?
    var sourceType:SourceType?
    var mainImageStringUrl:String?
    var dayText:String?
    var timeText:String?
    var programDescription:String?
    var subtitle:String?
    var channelLogoStringUrl:String?
    var numberOfLeftTitleLines:Int = 0
//    var mainImageContentMode:UIViewContentMode? = nil
    var cwProgress:Float = 0.0 //continue watching progress
    var epgAiring:Airing?
    var homeImageUrl:String?
    var awayImageUrl:String?
    var leftSubTitle:String?
    
    init() {
        
    }
    
    init(with model:Movie) {
        
        self.isLive = model.isLive
        self.title = model.title
        self.mainImageStringUrl = model.posterImageURL
        
        cwProgress = model.airings?.first?.playheadPercentage ?? 0.0
        
        if model.sourceType == .vod {
            self.timeText = ""
//            self.dayText = L10n.watchNow.string
            self.numberOfLeftTitleLines = 2
        } else {
//            self.dayText = FuboDateStyler.getDateLabelText(tmrText: false, endedText: false, eventStartDate: model.airings?.first?.startDate, eventEndDate: model.airings?.first?.endDate)
//            self.timeText = FuboDateStyler.getShortTime(forDate: model.airings?.first?.startDate)
        }
        
        self.programDescription = model.longDescription
        self.subtitle = model.subtitle
        self.channelLogoStringUrl = model.airings?.first?.networkLogoOnWhiteURL
//        self.mainImageContentMode = .scaleAspectFill
    }
    
//    init(with model:FTSerieEpisodeModel, tmrText:Bool = false, endedText:Bool = false) {
//
//        self.isLive = model.isLive
//        self.title = model.seriesTitle
//        self.mainImageStringUrl = model.letterImage
//
//        cwProgress = model.airings?.first?.playheadPercentage ?? 0.0
//
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: tmrText, endedText: endedText, eventStartDate: model.airings?.first?.startDateTime, eventEndDate: model.airings?.first?.endDateTime)
//        self.timeText = FuboDateStyler.getShortTime(forDate: model.airings?.first?.startDateTime)
//
//        self.programDescription = model.subtitle
//        self.channelLogoStringUrl = model.airings?.first?.networkLogoOnWhiteUrl
//    }
    
//    init(with model:FuboSeriesModel) {
//        self.title = model.title
//        self.mainImageStringUrl = model.thumbnailUrl
//        self.dayText = L10n.series.string
//        self.timeText = ""
//        self.subtitle = model.seriesDescription
//        self.programDescription = model.seriesDescription
//        self.channelLogoStringUrl = model.networks.first?.networkLogoOnWhiteUrl
//    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    init(with model:DisplayNetworkSerie) {
        self.title = model.seriesTitle
        self.mainImageStringUrl = model.seriesLetterImageURL
//        self.dayText = L10n.series.string
        self.timeText = ""
    }
    
//    init(with model:FuboEpgAiringModel) {
//        self.title = model.title
//        self.isLive = model.isLive
//        self.mainImageStringUrl = model.thumbnailUrl
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: false, endedText: false, eventStartDate: model.startDate, eventEndDate: model.endDate)
//        self.timeText = FuboDateStyler.getShortTime(forDate: model.startDate)
//        self.programDescription = model.shortDescription
//    }
    
//    init(with model:EPGSchedule) {
//        //super.init()
//        guard let airing = model.airings?.first else {
//            return
//        }
//        self.title = airing.programTitle
//        self.mainImageStringUrl = airing.letterImageUrl
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: false, endedText: false, eventStartDate: airing.startDate, eventEndDate: airing.endDate)
//        self.timeText = FuboDateStyler.getShortTime(forDate: airing.startDate)
//        self.programDescription = airing.shortDescripitionEpg
//        self.contentType = airing.contentType
//        self.sourceType = airing.sourceType
//    }
    
    init(with model:Airing) {
        //super.init()
        self.title = model.programTitle
        self.isLive = model.isLive
        self.mainImageStringUrl = model.letterImageUrl
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: false, endedText: true, eventStartDate: model.startDate, eventEndDate: model.endDate)
//        self.timeText = FuboDateStyler.getShortTime(forDate: model.startDate)
        self.programDescription = model.programDescription
        self.contentType = model.contentType
        self.sourceType = model.sourceType
        self.epgAiring = model
        self.subtitle = model.shortDescripitionWristband
    }
    
    init(with model: LastWatched) {
        
        self.cwProgress = model.playheadPercentage
        self.title = model.program?.title
        self.isLive = model.isLive
        self.mainImageStringUrl = model.program?.letterImageURL
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: false, endedText: false, eventStartDate: model.startDate, eventEndDate: model.endDate)
//        self.timeText = FuboDateStyler.getShortTime(forDate: model.startDate)
        self.programDescription = model.program?.shortDescription
        self.sourceType = model.sourceType
        self.contentType = model.contentType
    }
    
    init(with model: SearchSeries) {
        
        self.title = model.name
        self.isLive = false
        self.mainImageStringUrl = model.letterImageUrl
        self.dayText = "SERIES"
        self.subtitle = ""
    }
    
    init(with model: SearchAiring) {
        
        self.title = model.program?.title
        if model.sourceType == .live {
            self.isLive = model.isLive
        }
        self.mainImageStringUrl = model.program?.letterImage
//        self.dayText = FuboDateStyler.getDateLabelText(tmrText: false,
//                                                       endedText: true,
//                                                       eventStartDate: model.accessRights?.airingStartTime,
//                                                       eventEndDate: model.accessRights?.airingEndTime)
//        self.timeText = FuboDateStyler.getShortTime(forDate: model.accessRights?.airingStartTime)
        self.sourceType = model.sourceType
        
        switch (model.program?.type ?? .unknown) {
        case .movie:
            var subtitleText = ""
            if let year = model.program?.movieMetadata?.releaseYear {
                subtitleText += "\(year)"
            }
            if let rating = model.program?.rating {
                subtitleText += subtitleText.isEmpty ? rating : (" | " + rating)
            }
            self.subtitle = subtitleText
        default:
            self.subtitle = model.program?.shortDescription
        }
        
        
        
        if self.dayText == nil || self.dayText == "" {
//            self.dayText = L10n.cwItemTitle.string.uppercased()
//            self.leftSubTitle = L10n.cwItemSubtitle.string.uppercased()
        }
    }
}


//MARK: - FTSwCellInfoModel
class FTCwCellInfoModel: CellInfoModel {
    
    var duration: String?
    var cwTitle: String?
    var cwSubtitle: String?
    
    //MARK: • Overrided
    override init(with model: LastWatched) {
        super.init(with: model)
        
//        self.cwTitle = L10n.cwItemTitle.string.uppercased()
//        self.cwSubtitle = L10n.cwItemSubtitle.string.uppercased()
        
        self.subtitle = model.generateSubtitle()
        self.channelLogoStringUrl = model.network?.networkLogoOnWhiteURL
        
        
        if let duration = model.duration {
//            self.duration = FuboDateStyler.formattedDuration(TimeInterval(duration), includeSeconds: false)
        }
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}


