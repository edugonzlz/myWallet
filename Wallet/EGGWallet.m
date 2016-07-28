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

-(NSUInteger)currenciesCount {

    return [self.currencies count];
}

-(NSArray *)currencies {

    NSMutableArray *currencies = [[NSMutableArray alloc]init];

    for (EGGMoney *money in self.moneys) {

        if (![currencies containsObject:money.currency]) {

            [currencies addObject:money.currency];
        }
    }
    return currencies;
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

-(NSUInteger)moneysCountForCurrency:(NSUInteger)section {

    return [self moneysForCurrency:section].count;
}

-(NSString *)rateNameForSection:(NSUInteger)section {

    if (section >= [self.currencies count]) {
        return @"Total";
    }
    return self.currencies[section];
}


-(EGGMoney *)moneyForIndexPath:(NSIndexPath *)indexPath {

    EGGMoney *money = [[EGGMoney alloc]init];

    // Si nos piden cualquier seccion por debajo del TOTAL
    if (indexPath.section < [self.currencies count]) {

        NSArray *moneys = [self moneysForCurrency:indexPath.section];

        // Si nos piden cualquier celda por debajo del SUBTOTAL
        if (indexPath.row < moneys.count ) {

            money = moneys[indexPath.row];
        }
    }

    return money;
}

-(NSArray *)moneysForCurrency:(NSUInteger)section {

    if (section >= [self.currencies count]) {

        return @[];
    }
    // Guardar los moneys de la section en un array
    NSMutableArray *moneys = [[NSMutableArray alloc]init];

    // Los moneys que coinciden con nuestro currencie los guardamos en el array
    for (EGGMoney *money in self.moneys) {
        if (self.currencies[section] == money.currency) {
            [moneys addObject:money];
        }
    }
    return moneys;
}

-(EGGMoney *)subtotal:(NSUInteger)forSection {

    //Devolvemos la suma de los elementos del array
    EGGMoney *subtotal = [[EGGMoney alloc]init];
    NSArray *moneys = [self moneysForCurrency:forSection];

    for (EGGMoney *money in moneys) {
        subtotal = [subtotal plus:money];
    }

    return subtotal;
}

-(EGGMoney *)total {

    EGGMoney *total = [[EGGMoney alloc]init];

    for (EGGMoney *money in self.moneys) {

        // Convertimos cada money de moneys en euros
        // Los sumamos
        total = [total plus:[money reduceToCurrency:@"EUR" withBroker:self.broker]];
    }
    return total;
}

@end
