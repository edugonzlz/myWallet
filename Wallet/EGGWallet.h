//
//  EGGWallet.h
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "EGGMoney.h"

@interface EGGWallet : NSObject<EGGMoney>

@property (nonatomic, readonly)NSUInteger moneysCount;
@property (nonatomic, readonly)NSArray *currencies;
@property (nonatomic, readonly)NSUInteger currenciesCount;

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency broker:(EGGBroker *)broker;

-(NSUInteger)moneysCountForCurrency:(NSUInteger)section;

-(NSString *)rateNameForSection:(NSUInteger)section;

-(EGGMoney *)moneyForIndexPath:(NSIndexPath *)indexPath;

-(EGGMoney *)subtotal:(NSUInteger)forSection;

-(EGGMoney *)total;

@end
