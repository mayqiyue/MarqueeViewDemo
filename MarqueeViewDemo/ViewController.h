//
//  ViewController.h
//  MarqueeViewDemo
//
//  Created by Mayqiyue on 11/9/15.
//  Copyright © 2015 mayqiyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeView.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet MarqueeView *marqueeView;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonAction:(id)sender;
@end

