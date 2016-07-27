//
//  EGGWallet.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import "EGGWallet.h"
#import "EGGBroker.h"

@interface EGGWallet()

@property (strong, nonatomic) NSMutableArray *moneys;
@property (strong, nonatomic) EGGBroker *broker;

@end

@implementation EGGWallet

-(NSUInteger)moneysCount {

    return [self.moneys count];
}

-(NSUInteger)ratesCount {

    return [self.broker ratesCount];
}

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency {

    if (self = [super init]) {

        EGGMoney *money = [[EGGMoney alloc]initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }

    return self;
}

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency broker:(EGGBroker *)broker {

    if (self = [super init]) {

        EGGMoney *money = [[EGGMoney alloc]initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];

        _broker = broker;
    }

    return self;
}

-(id<EGGMoney>)plus:(EGGMoney *)other {

    [self.moneys addObject:other];

    return self;
}

-(id<EGGMoney>)times:(NSInteger)multiplier {

    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];

    for (EGGMoney *money in self.moneys) {
        EGGMoney *newMoney = [money times:multiplier];
        [newMoneys addObject:newMoney];
    }
    self.moneys = newMoneys;
    
    return self;
}

-(id<EGGMoney>)reduceToCurrency:(NSString *)currency withBroker:(EGGBroker *)broker {

    EGGMoney *result = [[EGGMoney alloc]initWithAmount:0 currency:currency];

    for (EGGMoney *money in self.moneys) {
        result = [result plus: [money reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
}

-(NSUInteger)moneysCountForCurrency:(NSUInteger)currency {

    NSUInteger moneys = 0;
    NSString *curr = nil;

    if (currency == 0) {
        curr = @"EUR";
    }
    if (currency == 1) {
        curr = @"USD";
    }

    for (EGGMoney *money in self.moneys) {

        if (curr == money.currency) {
            moneys += 1;
        }
    }
    return  moneys;
}


@end
