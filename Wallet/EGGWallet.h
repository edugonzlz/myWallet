//
//  EGGWallet.h
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGGMoney.h"

@interface EGGWallet : NSObject<EGGMoney>

@property (nonatomic, readonly)NSUInteger moneysCount;
@property (nonatomic, readonly)NSUInteger ratesCount;

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency broker:(EGGBroker *)broker;

-(NSUInteger)moneysCountForCurrency:(NSUInteger)currency;

@end
