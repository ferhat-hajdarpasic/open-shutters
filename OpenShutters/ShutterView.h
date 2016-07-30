//
//  ShutterView.h
//  OpenShutters
//
//  Created by Sharad Thapa on 03/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.


#import <UIKit/UIKit.h>
static float deltaAngle;
@interface ShutterView : UIView
{
   // UIImageView  *backgroundImageView;
    UIImageView  *shadowimg;
    BOOL isInside;
    CGRect orgFrame;
    
}
-(void)resetFrame;
@property (nonatomic)NSInteger numberOfBlades;
@property CGAffineTransform startTransform;
@property (nonatomic,retain) UIImageView  *backgroundImageView;
@property (nonatomic,retain) UIImageView  *shadowimg;
@end
