//
//  EGGControllerTests.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGWalletTableViewController.h"
#import "EGGWallet.h"
#import "EGGBroker.h"

@interface EGGControllerTests : XCTestCase

@property (strong, nonatomic)EGGWalletTableViewController *walletVC;
@property (strong, nonatomic)EGGWallet *wallet;
@property (strong, nonatomic)EGGBroker *emptyBroker;

@end

@implementation EGGControllerTests

-(void)setUp {
    [super setUp];

    self.emptyBroker = [EGGBroker new];
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];

    self.wallet = [[EGGWallet alloc] initWithAmount:1 currency:@"USD" broker:self.emptyBroker];
    [self.wallet plus:[EGGMoney euroWithAmount:1]];
    [self.wallet plus:[EGGMoney euroWithAmount:3]];
    [self.wallet plus:[EGGMoney dollarWithAmount:10]];

    self.walletVC = [[EGGWalletTableViewController alloc] initWithModel:self.wallet];
}

-(void)tearDown {

    [super tearDown];

    self.wallet = nil;
    self.walletVC = nil;
    self.emptyBroker = nil;
}

// Si hay n divisas en el modelo, el dataSource devuelve n + 1 secciones
-(void)testThatNumberOfSectionsIsNumberOfCurrenciesPlusOne {

    NSUInteger currencies = [self.wallet currenciesCount] +1;

    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];

    XCTAssertEqual(currencies, sections, @"Numero de secciones = divisas + 1");

}

#define CURENCIE_SECTION 1
// Si hay n moneys en una divisa, el data source debe de devolver n + 1 celdas para esa sección
-(void)testThatNumberOfCellsForCurrencieIsNumberOfMoneysForCurrenciePlusOne {

    NSUInteger numberOfMoneysForCurrency = [self.wallet moneysCountForCurrency:CURENCIE_SECTION];

    NSUInteger rows = [self.walletVC tableView:self.walletVC numberOfRowsInSection:CURENCIE_SECTION];

    XCTAssertEqual(numberOfMoneysForCurrency +1, rows, @"Numero de celdas = numero de moneys + 1");
}

@end
