//
//  NSObject+GNUStepAddons.m
//  Wallet
//
//  Created by Edu González on 16/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import "NSObject+GNUStepAddons.h"
#import <objc/runtime.h>

@implementation NSObject (GNUStepAddons)

-(id)subclassResponsibility: (SEL)aSel {

        char prefix = class_isMetaClass(object_getClass(self)) ? '+': '-';

        [NSException raise: NSInvalidArgumentException
                    format:@"%@%c%@ should be overriden by its subclass",
         NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];

        return self;    // not reached
}

@end
