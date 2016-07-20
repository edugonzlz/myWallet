//
//  EGGMoney.m
//  Wallet
//
//  Created by Edu González on 16/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import "EGGMoney.h"
#import "NSObject+GNUStepAddons.h"
#import "EGGBroker.h"

@interface EGGMoney()

@end


@implementation EGGMoney

+(id)euroWithAmount:(NSInteger)amount {

    return [[EGGMoney alloc]initWithAmount:amount currency:@"EUR"];
}

+(id)dollarWithAmount:(NSInteger)amount {

    return [[EGGMoney alloc]initWithAmount:amount currency:@"USD"];
}

-(id)initWithAmount:(NSInteger)amount
           currency:(NSString *)currency {

    if (self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    return self;
}

-(id<EGGMoney>)times:(NSInteger)multiplier {

    EGGMoney *newMoney = [[EGGMoney alloc]initWithAmount:[self.amount integerValue] * multiplier
                                                currency:self.currency];

    return newMoney;

    // No se deberia llamar, sino que se deberia usar el de la subClase
    //    return [self subclassResponsibility:_cmd];
}

-(id<EGGMoney>)plus:(EGGMoney *)other {

    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];

    EGGMoney *total = [[EGGMoney alloc]initWithAmount:totalAmount currency:self.currency];

    return total;
}

-(id<EGGMoney>)reduceToCurrency:(NSString *)currency
                     withBroker:(EGGBroker *)broker {

    EGGMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyForCurrency:self.currency
                                                      toCurrency:currency]]doubleValue];

    // Comprobamos la divisa de origen y destino
    if ([self.currency isEqual:currency]) {

        result = self;

    } else if (rate == 0) {
        // No existe la tasa para convertir
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];

    } else {

        NSInteger newAmount = [self.amount integerValue] * rate;

        result = [[EGGMoney alloc]initWithAmount:newAmount currency:currency];
    }
    
    return result;

}

// MARK: - OverWritten
-(NSString *)description {

    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
}

-(BOOL)isEqual:(id)object {

    if ([self.currency isEqual:[object currency]]) {

        return [self amount] == [object amount];

    } else {

        return NO;
    }

}

-(NSUInteger)hash {

    return [self.amount integerValue];
}

@end
