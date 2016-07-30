//
//  ShutterView.m
//  OpenShutters
//
//  Created by Sharad Thapa on 03/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import "ShutterView.h"
@implementation ShutterView
#define BLADE_HEIGHT 15
#define BLADE_WIDTH 60
@synthesize numberOfBlades;
@synthesize startTransform;
-(id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+10, BLADE_WIDTH, BLADE_HEIGHT)]))
    {
        
        
        isInside=NO;
        self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, BLADE_WIDTH, BLADE_HEIGHT)];
        self.shadowimg = [[UIImageView alloc]initWithFrame:CGRectMake(-8,-10, BLADE_WIDTH*3, 200)];
        [self.shadowimg setImage:[UIImage imageNamed:@"shadow.png"]];
        
        

   

        
//        backgroundImageView.layer.masksToBounds = NO;
//        backgroundImageView.layer.cornerRadius = 5; // if you like rounded corners
//        backgroundImageView.layer.shadowOffset = CGSizeMake(25, 20);
//        backgroundImageView.layer.shadowRadius = 2;
//        backgroundImageView.layer.shadowOpacity = 0.3;
        
//        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(10,10,130,25)];
//        backgroundImageView.layer.masksToBounds = NO;
//        backgroundImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//        backgroundImageView.layer.shadowOffset = CGSizeMake(20.0f, 5.0f);
//        backgroundImageView.layer.shadowOpacity = 0.4f;
//        backgroundImageView.layer.shadowPath = shadowPath.CGPath;
        
        
       
        [self addSubview:self.shadowimg];
        [self addSubview:self.backgroundImageView];
     
        
    }
    
    
    return self;
}

-(void)resetFrame
{
    
    self.frame=orgFrame;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    // 2 - Calculate distance from center
//    float dx = touchPoint.x - self.backgroundImageView.center.x;
//    float dy = touchPoint.y - self.backgroundImageView.center.y;
//
//    if (CGRectContainsPoint(self.backgroundImageView.frame, [touch locationInView:self])) { //if touch is beginning on min slider
//        
//        isInside=YES;
//        
//        // 3 - Calculate arctangent value
//        deltaAngle = atan2(dy,dx);
//        // 4 - Save current transform
//        startTransform = self.backgroundImageView.transform;
//        NSLog(@"the touchPoint %f %f",touchPoint.x,touchPoint.y);
//        NSLog(@"the dx %f",dx);
//        NSLog(@"the shutter %f",self.backgroundImageView.center.x);
//        NSLog(@"the dy %f",dy);
//        
//    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    [super touchesMoved:touches withEvent:event];
    
//    UITouch *touch = [touches anyObject];
//    
//    //CGPoint touchLocation = [touch locationInView:touch.view];
//   
//       if(isInside){
//        
//        CGPoint pt = [touch locationInView:self];
//        float dx = pt.x  - self.backgroundImageView.center.x;
//        float dy = pt.y  - self.backgroundImageView.center.y;
//        float ang = atan2(dy,dx);
//        float angleDifference = deltaAngle - ang;
//       
//        
//        self.backgroundImageView.transform = CGAffineTransformRotate(startTransform, -angleDifference);
//           
//        
//    
//    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [super touchesEnded:touches withEvent:event];
//    
//    isInside=NO;
  
}

@end
