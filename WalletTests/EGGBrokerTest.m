//
//  EGGBrokerTest.m
//  Wallet
//
//  Created by Edu González on 19/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGMoney.h"
#import "EGGBroker.h"

@interface EGGBrokerTest : XCTestCase

@property(strong,nonatomic)EGGBroker *emptyBroker;
@property(strong, nonatomic)EGGMoney *oneDollar;
@end

@implementation EGGBrokerTest

-(void)setUp {
    [super setUp];

    self.emptyBroker = [EGGBroker new];
    self.oneDollar = [EGGMoney dollarWithAmount:1];

}

-(void)tearDown {

    [super tearDown];

    self.emptyBroker = nil;
    self.oneDollar = nil;

}

-(void)testSimpleReduction {

    EGGMoney *sum = [[EGGMoney dollarWithAmount:5] plus: [EGGMoney dollarWithAmount:5]];
    EGGMoney *reduced = [self.emptyBroker reduce:sum toCurrency: @"USD"];

    XCTAssertEqualObjects(sum, reduced, @"Conversion entre la misma moneda debe ser correcto. Conversion to same currency should be a NOP");
}

-(void)testReduction {

    [self.emptyBroker addRate:2 fromCurrency: @"EUR" toCurrency: @"USD"];

    EGGMoney *dollars = [EGGMoney dollarWithAmount:10];
    EGGMoney *euros = [EGGMoney euroWithAmount:5];

    EGGMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];

    XCTAssertEqualObjects(converted, euros, @"10$ es igual a 5€ con una tasa de cambio de 2:1");
}

-(void)testThatNoRateRaisesException {

    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"],@"No tener un rate debe causar una exception");
}

-(void) testThatNilConversionNotChangeMoney {

    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar
                                                        toCurrency:@"USD"],@"Cuando no se hace ninguna conversion debemos obtener el mismo money");
}

@end
