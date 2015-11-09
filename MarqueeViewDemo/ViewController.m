//
//  ViewController.m
//  MarqueeViewDemo
//
//  Created by Mayqiyue on 11/9/15.
//  Copyright © 2015 mayqiyue. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    BOOL isPlaying;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPlaying = YES;
    [self.button setTitle:@"stop" forState:UIControlStateNormal];
    self.button.backgroundColor =  [UIColor colorWithRed:114.0f/255.0f green:87.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
    
    self.marqueeView.backgroundColor = [UIColor colorWithRed:114.0f/255.0f green:87.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
    self.marqueeView.colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    self.marqueeView.switchInterval = 0.5f;
    [self.view addSubview:self.marqueeView];
    [self.marqueeView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonAction:(id)sender
{
    if (isPlaying) {
        [self.button setTitle:@"start" forState:UIControlStateNormal];
        [self.marqueeView stop];
    }
    else {
        [self.button setTitle:@"stop" forState:UIControlStateNormal];
        [self.marqueeView start];
    }
    isPlaying = !isPlaying;
}
@end
