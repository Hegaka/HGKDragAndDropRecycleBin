//  Copyright (c) 2011 Hegaka
//  All rights reserved

#import "HegakaDragAndDropRecycleBinViewController.h"
#import "AttachmentItem.h"

@implementation HegakaDragAndDropRecycleBinViewController

@synthesize gallery;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gallery.mainView = self.view;
    
    
    AttachmentItem *item = [[AttachmentItem alloc] initWithData:1 data:nil];
    [self.gallery addAttachment:item];
    [self.gallery addAttachment:item];
    [self.gallery addAttachment:item];
    [self.gallery addAttachment:item];
    [self.gallery addAttachment:item];
    [item release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
