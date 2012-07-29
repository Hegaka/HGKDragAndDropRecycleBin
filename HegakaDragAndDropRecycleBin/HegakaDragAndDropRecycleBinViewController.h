/*
 * Copyright        : Copyright (c) 2011 Hegaka
 * Author           : Jon Arrien
 * Twitter          : @jonarrien
 * All right reserved
 */

#import <UIKit/UIKit.h>
#import "GalleryScrollView.h"

@interface HegakaDragAndDropRecycleBinViewController : UIViewController {
    IBOutlet GalleryScrollView *gallery;
}

@property (nonatomic, retain) IBOutlet GalleryScrollView *gallery;

@end
