//
//  SegmentioBuilder.swift
//  TEST
//
//  Created by Sinakhanjani on 9/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import Segmentio

struct SegmentioBuilder {
    /*
     static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
     segmentioView.addBadge(
     at: index,
     count: 10,
     color: ColorPalette.coral
     )
     }
     */
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3), content: [SegmentioItem]) {
        segmentioView.setup(
            content: content,
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: #colorLiteral(red: 0.1156940684, green: 0.6866512299, blue: 0.6498344541, alpha: 1),
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.init(name: IRAN_SANS_MOBILE_FONT, size: 14)! // تعویض فونت و رنگ امیزی سگمنت ها
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            ),
            selectedState: segmentioState(
                backgroundColor: #colorLiteral(red: 0.1156940684, green: 0.6866512299, blue: 0.6498344541, alpha: 1),
                titleFont: font,
                titleTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            ),
            highlightedState: segmentioState(
                backgroundColor: #colorLiteral(red: 0.1156940684, green: 0.6866512299, blue: 0.6498344541, alpha: 1),
                titleFont: font,
                titleTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 0.3,
            color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        )
    }
    
    
}

