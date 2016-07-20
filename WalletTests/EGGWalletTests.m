//
//  EGGWalletTests.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGMoney.h"
#import "EGGBroker.h"
#import "EGGWallet.h"

@interface EGGWalletTests : XCTestCase

@end

@implementation EGGWalletTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testAdditionWithReduction {
//
//    EGGBroker *broker = [EGGBroker new];
//    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
//
//    EGGWallet *wallet = [[EGGWallet alloc]initWithAmount:40 currency:@"EUR"];
//    [wallet plus:[EGGMoney dollarWithAmount: 20]];
//
//    EGGMoney *reduced = [broker reduce:wallet toCurrency:@"USD"];
//
//    EGGMoney *hundredDollars = [EGGMoney dollarWithAmount:100];
//    
//    XCTAssertEqualObjects(reduced, hundredDollars, @"40€ + 20$ = 100$ 2:1");
//}

@end
