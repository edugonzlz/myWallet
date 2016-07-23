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

@interface EGGControllerTests : XCTestCase

@property (strong, nonatomic)EGGWalletTableViewController *walletVC;
@property (strong, nonatomic)EGGWallet *wallet;

@end

@implementation EGGControllerTests

- (void)setUp {
    [super setUp];

    self.wallet = [[EGGWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[EGGMoney euroWithAmount:1]];
    self.walletVC = [[EGGWalletTableViewController alloc] initWithModel:self.wallet];

}

- (void)tearDown {

    [super tearDown];

}

-(void)testThatTableHasOneSection {

    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];

    XCTAssertEqual(sections, 1, @"Solo debe haber una seccion");
}

-(void)testThatNumberOfCellsIsNumberOfMoneysPlusOne {

    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Numero de celdas = numero de moneys + 1");
}
@end
