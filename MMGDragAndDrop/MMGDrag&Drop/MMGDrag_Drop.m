//
//  MMGDrag&Drop.m
//  MOVEME
//
//  Created by Mohamed Mitwaly on 7/20/14.
//  Copyright (c) 2014 Tawasol. All rights reserved.
//

#import "MMGDrag_Drop.h"

@implementation MMGDrag_Drop{
    CGPoint imagePoint;
    CGPoint startPoint;
    CGPoint currePoint;
    CGFloat lastScale;
    UIView* view;
}
static MMGDrag_Drop* instance;
+(MMGDrag_Drop *)getInstance{
    if (!instance) {
        instance=[[MMGDrag_Drop alloc]init];  //returning object from class
    }
    return instance;
}

-(int)arrayOfPhotosToBeDraggedAndDrop:(NSArray *)photosArray onView:(UIView*)mainView{
    if (mainView) {
        view=mainView;
        lastScale=1;
        if (photosArray) {
            for (int i =0; i<photosArray.count; i++) {
                if ([photosArray[i] isKindOfClass:[UIView class]]) {
                    UIPanGestureRecognizer* tapGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
                    [tapGes setDelegate:self];
                    [(UIImageView*)photosArray[i] addGestureRecognizer:tapGes];
                    UIPinchGestureRecognizer* pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIMage:)];
                    [pinchGes setDelegate:self];
                    [(UIImageView*)photosArray[i] addGestureRecognizer:pinchGes];
                }  
            }
            return 1;
        }else{
            return 2;
        }
    }else{
        return 0;
    }
}

-(void)moveImage:(UITapGestureRecognizer*)tapGes
{
    UIImageView* tempImageView = (UIImageView*)[tapGes view];
    if(tapGes.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [tapGes locationInView:view];
        imagePoint=tempImageView.frame.origin;
    }
    else if(tapGes.state == UIGestureRecognizerStateChanged)
    {
        currePoint = [tapGes locationInView:view];
        if(!CGPointEqualToPoint(currePoint,startPoint))
        {
            CGRect temprect = tempImageView.frame;
            temprect.origin.x = imagePoint.x + currePoint.x-startPoint.x;
            temprect.origin.y = imagePoint.y + currePoint.y-startPoint.y;
            tempImageView.frame = temprect;
        } 
    }else if (tapGes.state == UIGestureRecognizerStateEnded){
        imagePoint=tempImageView.frame.origin;
    }
}

-(void)zoomIMage:(UIPinchGestureRecognizer*)pinchGes{
    UIImageView* tempImageView = (UIImageView*)[pinchGes view];
    [UIView animateWithDuration:.1 animations:^{
        CGRect tempRect = CGRectMake(tempImageView.frame.origin.x, tempImageView.frame.origin.y, tempImageView.frame.size.width+ (tempImageView.frame.size.width * ([pinchGes scale] - lastScale)),tempImageView.frame.size.height + (tempImageView.frame.size.height* ([pinchGes scale] - lastScale)));
        tempImageView.frame = tempRect;
        lastScale=[pinchGes scale];
    }];
    if (pinchGes.state == UIGestureRecognizerStateEnded)
    {
        lastScale=1;
    }
}
@end