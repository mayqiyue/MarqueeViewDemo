//
//  MarqueeView.m
//  iFun
//
//  Created by Mayqiyue on 11/7/15.
//  Copyright © 2015 AppFinder. All rights reserved.
//

#import "MarqueeView.h"

#pragma mark- MarqueeLayer
@interface MarqueeLayer : CALayer
@property (nonatomic, strong) NSArray<UIColor*> *colors;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat itemRadius;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, strong) NSArray *layerCircleFrame;
@end

@implementation MarqueeLayer

- (void)drawInContext:(CGContextRef)ctx
{
    for (NSInteger i = 0; i < _layerCircleFrame.count; i++) {
        UIColor *color = _colors[i % _colors.count];
        if (i == _layerCircleFrame.count-1 && (i % _colors.count) == 0) { // To avoid the last circle's color equal to the first's
            color = (_colors.count > 1)?_colors[1]:color;
        }
        [self _drawCircleWithFrame:CGRectFromString(_layerCircleFrame[i]) context:ctx color:color];
    }
}

- (void)_drawCircleWithFrame:(CGRect)frame context:(CGContextRef)context color:(UIColor *)color
{
    CGRect rect = frame;
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, self.backgroundColor);
    CGContextFillRect(context, rect);
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
}

@end

//<---------------------------------------------------------------------------------------------------------------------------->//
//<---------------------------------------------------------------------------------------------------------------------------->//
#pragma mark-
#pragma mark- MarqueeView

@interface MarqueeView ()
@property (nonatomic, strong) NSMutableArray<MarqueeLayer *> *marqueeLayers;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray *circleFrame;
@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)dealloc
{
    self.timer = nil;
}

- (void)commonInit
{
    _colors = @[[UIColor redColor], [UIColor whiteColor]];
    _insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    _itemRadius = 2.0f;
    _minimumInteritemSpacing = 5.0f;
    _switchInterval = 0.5f;
    _index = 0;
}

- (void)_switchLayersAnimation
{
    _index = _index % _marqueeLayers.count;
    [self.layer addSublayer:_marqueeLayers[_index]];
    [self.layer insertSublayer:_marqueeLayers[_index] atIndex:0];
    _index ++;
}

#pragma mark- Public methods

- (void)start
{
    [self initCirclesFrames];
    [self initMarqureeLayers];
    [self initTimer];
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
    _index = 0;
}

#pragma mark- Private methods

- (void)initMarqureeLayers
{
    if (!_marqueeLayers) {
        _marqueeLayers = [[NSMutableArray alloc] initWithCapacity:_colors.count];
        for (NSInteger i = 0; i < _colors.count; i++) {
            [_marqueeLayers addObject:[self _marqueeLayerWithColors:_colors offset:i]];
        }
    }
}

- (void)initTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_switchInterval target:self selector:@selector(_switchLayersAnimation) userInfo:nil repeats:YES];
    }
}

- (MarqueeLayer *)_marqueeLayerWithColors:(NSArray *)colors offset:(NSInteger)offset
{
    MarqueeLayer *layer = [MarqueeLayer layer];
    layer.backgroundColor = self.backgroundColor.CGColor;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.frame = self.bounds;
    layer.layerCircleFrame = _circleFrame;
    layer.insets = _insets;
    layer.itemRadius = _itemRadius;
    layer.minimumInteritemSpacing = _minimumInteritemSpacing;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:colors.count];
    for (NSInteger i = offset; i < colors.count; i++) {
        [array addObject:colors[i]];
    }
    for (NSInteger i = 0; i < offset; i++) {
        [array addObject:colors[i]];
    }
    
    layer.colors = array;
    [layer setNeedsDisplay];
    return layer;
}

- (void)initCirclesFrames
{
    if (!_circleFrame) {
        _circleFrame = [[NSMutableArray alloc] init];
        unsigned int rowCount = 0, columnCount = 0;
        rowCount = floor((self.frame.size.width-_insets.left-_insets.right+_minimumInteritemSpacing)/(_minimumInteritemSpacing+2*_itemRadius));
        columnCount = floor((self.frame.size.height-_insets.top-_insets.bottom+_minimumInteritemSpacing)/(_minimumInteritemSpacing+2*_itemRadius));
        CGFloat realItemSpacing = (self.frame.size.width-_insets.left-_insets.right-rowCount*2*_itemRadius)/(rowCount-1);
        CGFloat realColumnItemSpacing = (self.frame.size.height-_insets.top-_insets.bottom-columnCount*2*_itemRadius)/(columnCount-1);
        
        CGRect frame = CGRectZero;
        unsigned int totalCount = rowCount*2+(columnCount-2)*2;
        for (NSInteger i = 0; i < totalCount; i++) {
            if (i < rowCount) {
                frame = CGRectMake(_insets.left+i*(_itemRadius*2+realItemSpacing), _insets.top, _itemRadius*2, _itemRadius*2);
            }
            else if (i < rowCount + columnCount-2) {
                frame = CGRectMake(_insets.left+(rowCount-1)*(_itemRadius*2+realItemSpacing),
                                   _insets.top + (i-(rowCount-1))*(_itemRadius*2+realColumnItemSpacing),
                                   _itemRadius*2,
                                   _itemRadius*2);
            }
            else if (i < rowCount*2 + columnCount-2) {
                frame = CGRectMake(self.bounds.size.width-_insets.right-(i - (rowCount+(columnCount-2)))*(_itemRadius*2+realItemSpacing)-_itemRadius*2,
                                   self.frame.size.height - _insets.bottom - _itemRadius*2,
                                   _itemRadius*2,
                                   _itemRadius*2);
            }
            else {
                frame = CGRectMake(_insets.left,
                                   self.frame.size.height -  (_insets.bottom + _itemRadius*2+(i-(rowCount*2+columnCount-3))*(_itemRadius*2+realColumnItemSpacing)),
                                   _itemRadius*2,
                                   _itemRadius*2);
            }
            [_circleFrame addObject:NSStringFromCGRect(frame)];
        }
    }
}

@end
