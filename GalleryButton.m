/*
 * Copyright        : Copyright (c) 2011 Hegaka
 * Author           : Jon Arrien
 * Twitter          : @jonarrien
 * All right reserved
 */


#import <QuartzCore/QuartzCore.h>
#import "GalleryButton.h"
#import "GalleryScrollView.h"

@implementation GalleryButton

@synthesize delegate;
@synthesize originalPosition = _originalPosition;
@synthesize mainView, scrollParent;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){

        isInScrollview	= YES;

        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 15, 34, 34)];
        [activityIndicator startAnimating];
        activityIndicator.userInteractionEnabled = NO;
        [self addSubview:activityIndicator];
        [activityIndicator release];

        self.backgroundColor = [UIColor blackColor];
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 7;
    }
    return self;
}


#pragma mark - DRAG AND DROP

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.delegate touchDown];
    self.originalPosition = self.center;
    self.scrollParent.scrollEnabled = NO;

	if (isInScrollview == YES) {
		CGPoint newLoc = CGPointZero;
        newLoc = [[self superview] convertPoint:self.center toView:self.mainView];
        _originalOutsidePosition = newLoc;

        //		[self.superview touchesCancelled:touches withEvent:event];
		[self removeFromSuperview];

        self.center = newLoc;
		[self.mainView addSubview:self];
        [self.mainView bringSubviewToFront:self];
		isInScrollview = NO;
	}
	else {
		;
	}

}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

	[UIView beginAnimations:@"stalk" context:nil];
	[UIView setAnimationDuration:.001];
	[UIView setAnimationBeginsFromCurrentState:YES];

	UITouch *touch = [touches anyObject];
	self.center = [touch locationInView: self.superview];

	[UIView commitAnimations];

    if ([delegate isInsideRecycleBin:self touching:NO]){

    }

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if ([delegate isInsideRecycleBin:self touching:YES]){
        UIImageView * animation = [[UIImageView alloc] init];
        animation.frame = CGRectMake(self.center.x - 32, self.center.y - 32, 40, 40);

        animation.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed: @"iconEliminateItem1.png"],
                                     [UIImage imageNamed: @"iconEliminateItem2.png"],
                                     [UIImage imageNamed: @"iconEliminateItem3.png"],
                                     [UIImage imageNamed: @"iconEliminateItem4.png"]
                                     ,nil];
        [animation setAnimationRepeatCount:1];
        [animation setAnimationDuration:0.35];
        [animation startAnimating];
        [self.mainView addSubview:animation];
        [animation bringSubviewToFront:self.mainView];
        [animation release];
        ;
    } else{
        [UIView beginAnimations:@"goback" context:nil];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.center = _originalOutsidePosition;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
        //        loadingView.frame = CGRectMake(rect.origin.x, rect.origin.y - 80, rect.size.width, rect.size.height);

        [UIView commitAnimations];

    }

    [self.delegate touchUp];

}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID isEqualToString:@"goback"] && finished) {
        [self removeFromSuperview];
        self.center = _originalPosition;
        [self.scrollParent addSubview:self];
        isInScrollview = YES;
    }
}



@end
