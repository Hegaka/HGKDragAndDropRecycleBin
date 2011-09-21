//  Copyright (c) 2011 Hegaka
//  All rights reserved


#import <UIKit/UIKit.h>
#import "AttachmentItem.h"
#import "GalleryButton.h"

@protocol GAlleryScrollDelegate;

@interface GalleryScrollView : UIView <GalleryButtonDelegate>
{
    
    id <GAlleryScrollDelegate> delegate;
    
    // MAIN WINDOW WHERE YOU CAN DRAG ICONS
    UIView *mainView;
    
    UIScrollView *_scrollView;
    NSMutableArray *_attachments;
    
    
    NSInteger *_totalSize;
    
    UIImageView *_recycleBin;
    CGRect recycleBinFrame;
    
}

@property (nonatomic, retain) id <GAlleryScrollDelegate> delegate;

@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) NSMutableArray *attachments;

@property (nonatomic, retain) UIImageView *recycleBin;
@property (nonatomic) CGRect recycleBinFrame;

- (void) addAttachment:(AttachmentItem *)attachment;
- (void) removeAttachment:(GalleryButton *)button;
- (void) reloadData;


@end

// EVENTS IF YOU WANT TO DISABLE SOME SCROLL ON DID PRESS AND ENABLE IT ON DROP
@protocol GAlleryScrollDelegate
- (void) didPressButton;
- (void) didDropButton;
@end