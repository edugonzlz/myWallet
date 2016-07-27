//
//  EGGBroker.m
//  Wallet
//
//  Created by Edu González on 19/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import "EGGBroker.h"
#import "EGGMoney.h"

@interface EGGBroker()


@end


@implementation EGGBroker

-(id)init {
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }

    return self;
}

-(NSUInteger)ratesCount {

    // Devolvemos el numero de rates/2 porque para cada rate hemos guardado el inverso
    NSUInteger count = self.rates.count/2;

    return count;
}

-(EGGMoney *)reduce:(id<EGGMoney>)money
         toCurrency:(NSString *)currency {

    // double dispatch
    return [money reduceToCurrency:currency withBroker:self];

   }

-(void)addRate:(NSInteger)rate
  fromCurrency:(NSString *)fromCurrency
    toCurrency:(NSString *)toCurrency {

    [self.rates setObject:@(rate)
                   forKey:[self keyForCurrency:fromCurrency toCurrency:toCurrency]];
    // Guardamos tambien la tasa de cambio inversa
    NSNumber *invRate = @(1.0/rate);
    [self.rates setObject:invRate
                   forKey:[self keyForCurrency:toCurrency toCurrency:fromCurrency]];
}


// MARK: - utils
-(NSString *)keyForCurrency:(NSString *)fromCurrency
                 toCurrency:(NSString *)toCurrency {

    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}
@end
