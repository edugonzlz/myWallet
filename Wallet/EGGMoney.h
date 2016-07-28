//
//  EGGMoney.h
//  Wallet
//
//  Created by Edu González on 16/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGGBroker;
@class EGGMoney;

@protocol EGGMoney <NSObject>

-(id)initWithAmount:(NSInteger)amount
           currency:(NSString *) currency;

-(id<EGGMoney>)times:(NSInteger)multiplier;

-(id<EGGMoney>)plus:(EGGMoney *)other;

-(id<EGGMoney>)reduceToCurrency:(NSString *)currency
                     withBroker:(EGGBroker *)broker;

@end


@interface EGGMoney : NSObject<EGGMoney>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

+(id) euroWithAmount:(NSInteger)amount;

+(id) dollarWithAmount:(NSInteger)amount;

+(id) yenWithAmount:(NSInteger)amount;

@end
