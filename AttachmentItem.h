/*
 * Copyright        : Copyright (c) 2011 Hegaka
 * Author           : Jon Arrien
 * Twitter          : @jonarrien
 * All right reserved
 */

 #import <Foundation/Foundation.h>

@interface AttachmentItem : NSObject {

    int type;
	NSData *data;

}

@property (nonatomic) int type;
@property (nonatomic, retain) NSData *data;


-(id)initWithData:(int)dataType data:(NSData *)dataBytes;

@end
