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

- (void)setUp {
    [super setUp];

    self.emptyBroker = [EGGBroker new];
    [self.emptyBroker addRate:3 fromCurrency:@"YEN" toCurrency:@"USD"];
    [self.emptyBroker addRate:4 fromCurrency:@"POUND" toCurrency:@"EUR"];

    self.wallet = [[EGGWallet alloc] initWithAmount:1 currency:@"USD" broker:self.emptyBroker];
    self.wallet = [[EGGWallet alloc] initWithAmount:3 currency:@"USD" broker:self.emptyBroker];
    [self.wallet plus:[EGGMoney euroWithAmount:1]];
    [self.wallet plus:[EGGMoney euroWithAmount:1]];

    self.walletVC = [[EGGWalletTableViewController alloc] initWithModel:self.wallet];


}

- (void)tearDown {

    [super tearDown];

    self.wallet = nil;
    self.walletVC = nil;
    self.emptyBroker = nil;
}


//-(void)testThatTableHasOneSection {
//
//    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
//
//    XCTAssertEqual(sections, 1, @"Solo debe haber una seccion");
//}

// Si hay n divisas en el modelo, el dataSource devuelve n + 1 secciones
-(void)testThatNumberOfSectionsIsNumberOfCurrenciesPlusOne {

    NSUInteger currencies = [self.wallet ratesCount] +1;

    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];

    XCTAssertEqual(currencies, sections, @"Numero de secciones = divisas + 1");

}

// Si hay n moneys en una divisa, el data source debe de devolver n + 1 celdas para esa sección
-(void)testThatNumberOfCellsForCurrencieIsNumberOfMoneysForCurrenciePlusOne {

    NSUInteger numberOfMoneysForCurrency = [self.wallet moneysCountForCurrency: EUR_SECTION];

    NSUInteger rows = [self.walletVC tableView:self.walletVC numberOfRowsInSection:EUR_SECTION];

    XCTAssertEqual(numberOfMoneysForCurrency +1, rows, @"Numero de celdas = numero de moneys + 1");
}



@end
