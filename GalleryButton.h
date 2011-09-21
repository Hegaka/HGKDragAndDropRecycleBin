//  Copyright (c) 2011 Hegaka
//  All rights reserved


#import <UIKit/UIKit.h>

@protocol GalleryButtonDelegate;

@interface GalleryButton : UIView
{
    
    id<GalleryButtonDelegate> delegate;
    
    CGPoint _originalPosition;
    CGPoint _originalOutsidePosition;
    
    BOOL isInScrollview;
    
    // PARENT VIEW WHERE THE VIEWS CAN BE DRAGGED
    UIView *mainView;
    // SCROLL VIEW WHERE YOU GONNA PUT THE THUMBNAILS
    UIScrollView *scrollParent;
}

@property (nonatomic, retain) id<GalleryButtonDelegate> delegate;

@property (nonatomic) CGPoint originalPosition;

@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UIScrollView *scrollParent;

@end


@protocol GalleryButtonDelegate
-(void) touchDown;
-(void) touchUp;
-(BOOL) isInsideRecycleBin:(GalleryButton *)button touching:(BOOL)finished;
@end


