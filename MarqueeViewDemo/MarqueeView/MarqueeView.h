//
//  MarqueeView.h
//  iFun
//
//  Created by Mayqiyue on 11/7/15.
//  Copyright © 2015 AppFinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeView : UIView

@property (nonatomic, copy) NSArray<UIColor*> *colors; // The colors of items

@property (nonatomic, assign) UIEdgeInsets insets; // The insets of items, default is {5.0f, 5.0f, 5.0f, 5.0f}
@property (nonatomic, assign) CGFloat itemRadius; // The radius of items, default is 2.0f
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; // The minimun spacing between items, default is 5.0f

@property (nonatomic, assign) CGFloat switchInterval; // Animation interval, default is 0.5f

- (void)start;
- (void)stop;

@end
