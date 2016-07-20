//
//  EGGBroker.h
//  Wallet
//
//  Created by Edu González on 19/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGGMoney.h"

@interface EGGBroker : NSObject

@property (strong, nonatomic)NSMutableDictionary *rates;

-(EGGMoney *)reduce:(id<EGGMoney>)money
         toCurrency:(NSString *)currency;

-(void)addRate:(NSInteger)rate
  fromCurrency:(NSString *)fromCurrency
    toCurrency:(NSString *)toCurrency;

-(NSString *)keyForCurrency:(NSString *)fromCurrency
                 toCurrency:(NSString *)toCurrency;
@end
