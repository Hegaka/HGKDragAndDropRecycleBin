/*
 * Copyright        : Copyright (c) 2011 Hegaka
 * Author           : Jon Arrien
 * Twitter          : @jonarrien
 * All right reserved
 */


#import <QuartzCore/QuartzCore.h>
#import "GalleryScrollView.h"
#import "GalleryButton.h"

@implementation GalleryScrollView


@synthesize delegate;
@synthesize mainView;
@synthesize attachments = _attachments;
@synthesize recycleBin = _recycleBin, recycleBinFrame;


int padding = 3;


#pragma mark - INIT

- (id) init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        ;
    }
    return self;
}

- (void) awakeFromNib
{
    // INIT ATTACHMENT ARRAY
    if (_attachments == nil){
        _attachments = [[NSMutableArray alloc] init];
    }

    // SCROLL VIEW
    UIScrollView *scrollTemp = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-90, 80)];
    _scrollView = scrollTemp;
    _scrollView.backgroundColor = [UIColor clearColor];

    // RECYCLE BIN
    UIImageView *imageViewTemp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recyclebin.png"]];
    self.recycleBin = imageViewTemp;
    self.recycleBin.frame = CGRectMake(self.frame.size.width-73, padding, 64, 64);

    [self addSubview:_scrollView];
    [self addSubview:self.recycleBin];
    [scrollTemp release];
    [imageViewTemp release];
}


- (void) dealloc {
    [super dealloc];

}


#pragma mark - ATTACHMENTS ADD / REMOVE

- (void) addAttachment:(AttachmentItem *)attachment
{
    // SAVE ATTACHMENT
    [_attachments addObject:attachment];

    // RESIZE CONTENT VIEW FOR INSERTINT NEW ATTACHMENT
    _scrollView.contentSize = CGSizeMake([_attachments count]*70, 70);

    CGFloat startX = (70.0f * ((float)[_attachments count] - 1.0f) + padding);
    CGFloat startY = padding;
    CGFloat width = 64;
    CGFloat height = 64;

    GalleryButton *btnAttachment = [[GalleryButton alloc] initWithFrame:CGRectMake(startX, startY, width, height)];
    btnAttachment.tag = [_attachments count];
    btnAttachment.scrollParent = _scrollView;
    btnAttachment.mainView = self.mainView;
    btnAttachment.delegate = self;

    if (attachment.type == 1){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        imageView.image=[UIImage imageWithData:attachment.data];
        [btnAttachment addSubview:imageView];
        [imageView release];
    }else if (attachment.type == 2){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        imageView.image=[UIImage imageNamed:@"iconSoundFile.png"];
        [btnAttachment addSubview:imageView];
        [imageView release];
    } else if (attachment.type == 3){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        imageView.image=[UIImage imageNamed:@"iconVideoCamera.png"];
        [btnAttachment addSubview:imageView];
        [imageView release];
    }

    [_scrollView addSubview:btnAttachment];
    [btnAttachment release];

}


- (void) removeAttachment:(GalleryButton *)button
{

    // MOVE THE OTHERS BUTTON TO LEFT
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_scrollView cache:YES];

    int position = (button.originalPosition.x - 35) / 70;

    // ARRAY FOR SAVING THE ONES WE NEED
    NSMutableArray *itemsToKeep = [NSMutableArray arrayWithCapacity:[_attachments count]];
    NSUInteger idx = 0;
    for (AttachmentItem *item in _attachments) {
        if (idx != position) {
            [itemsToKeep addObject:item];
        }
        idx++;
    }
    [_attachments setArray:itemsToKeep];

    // REMOVE THE BUTTON
    [button removeFromSuperview];

    [self reloadData];

    [UIView commitAnimations];

}

#pragma mark - RELOAD DATA

- (void) reloadData
{
    for (UIView *vi in _scrollView.subviews){
        [vi removeFromSuperview];
    }

    for (int i=0; i<[_attachments count] ; i++) {
        AttachmentItem *item = [_attachments objectAtIndex:i];
        _scrollView.contentSize = CGSizeMake([_attachments count]*70, 70);

        CGFloat startX = (70.0f * i) + padding;
        CGFloat startY = padding;
        CGFloat width = 64;
        CGFloat height = 64;

        GalleryButton *btnAttachment = [[GalleryButton alloc] initWithFrame:CGRectMake(startX, startY, width, height)];
        btnAttachment.tag = [_attachments count];
        btnAttachment.scrollParent = _scrollView;
        btnAttachment.mainView = self.mainView;
        btnAttachment.delegate = self;

        if (item.type == 1){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
            imageView.image=[UIImage imageWithData:item.data];
            [btnAttachment addSubview:imageView];
            [imageView release];
        }else if (item.type == 2){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
            imageView.image=[UIImage imageNamed:@"iconSoundFile.png"];
            [btnAttachment addSubview:imageView];
            [imageView release];
        } else if (item.type == 3){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
            imageView.image=[UIImage imageNamed:@"iconVideoCamera.png"];
            [btnAttachment addSubview:imageView];
            [imageView release];
        }

        [_scrollView addSubview:btnAttachment];
        [btnAttachment release];

    }

}


#pragma mark - GALLERY BUTTON DELEGATE

-(void) touchDown
{
    [self.delegate didPressButton];
}

-(void) touchUp
{
    [self.delegate didDropButton];
    _scrollView.scrollEnabled = YES;
}

-(BOOL) isInsideRecycleBin:(GalleryButton *)button touching:(BOOL)finished;
{
    CGPoint newLoc = [self convertPoint:self.recycleBin.frame.origin toView:self.mainView];
    CGRect binFrame = self.recycleBin.frame;
    binFrame.origin = newLoc;

    if (CGRectIntersectsRect(binFrame, button.frame) == TRUE){
        if (finished){
            [self removeAttachment:button];
        }
        return YES;
    }
    else {
        return NO;
    }

}

@end
