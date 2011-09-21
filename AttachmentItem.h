//  Copyright (c) 2011 Hegaka
//  All rights reserved

#import <Foundation/Foundation.h>

@interface AttachmentItem : NSObject {
    
    int type;
	NSData *data;
    
}

@property (nonatomic) int type;
@property (nonatomic, retain) NSData *data;


-(id)initWithData:(int)dataType data:(NSData *)dataBytes;

@end