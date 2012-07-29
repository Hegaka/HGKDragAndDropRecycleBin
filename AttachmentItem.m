/*
 * Copyright        : Copyright (c) 2011 Hegaka
 * Author           : Jon Arrien
 * Twitter          : @jonarrien
 * All right reserved
 */

#import "AttachmentItem.h"


@implementation AttachmentItem

@synthesize type, data;

-(id)initWithData:(int)dataType data:(NSData *)dataBytes;
{
    self.type=dataType;
    self.data=dataBytes;
    return self;
}


@end
