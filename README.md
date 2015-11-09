# MarqueeViewDemo
This is a small but great control for iOS apps!

![](./../marqueeViewEffect.gif)

# Supported OS & SDK Versions

Supported: - iOS 6.0+    
NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this OS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.

# Installation

To use the MarqueeView in an app, just drag the entire MarqueeView folder in applicaiton's root directory into your project.

# Property

###The MarqueeView only has the following properties:

    @property (nonatomic, copy) NSArray<UIColor*> *colors;
The colors of items*

    @property (nonatomic, assign) UIEdgeInsets insets;       
The insets of items, default is {5.0f, 5.0f, 5.0f, 5.0f}

    @property (nonatomic, assign) CGFloat itemRadius;    
The radius of items, default is 2.0f

    @property (nonatomic, assign) CGFloat minimumInteritemSpacing;     
The minimun spacing between items, default is 5.0f

    @property (nonatomic, assign) CGFloat switchInterval;    
Animation interval, default is 0.5f

# Contact

If you have any problem, just contact with me: xu20121013@gmail.com! I would pleasure for that!
And here is one of my app used MarqueeView: 
