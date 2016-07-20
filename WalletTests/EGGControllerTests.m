//
//  EGGControllerTests.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGSimpleViewController.h"
#import "EGGWalletTableViewController.h"
#import "EGGWallet.h"

@interface EGGControllerTests : XCTestCase

@property (strong, nonatomic)EGGSimpleViewController *simpleVC;
@property (strong, nonatomic)UIButton *button;
@property (strong, nonatomic)UILabel *label;

@property (strong, nonatomic)EGGWalletTableViewController *walletVC;
@property (strong, nonatomic)EGGWallet *wallet;

@end

@implementation EGGControllerTests

- (void)setUp {
    [super setUp];

    self.simpleVC = [[EGGSimpleViewController alloc]initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola Mozoncillo" forState:UIControlStateNormal];
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;

    self.wallet = [[EGGWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[EGGMoney euroWithAmount:1]];
    self.walletVC = [[EGGWalletTableViewController alloc] initWithModel:self.wallet];

}

- (void)tearDown {

    [super tearDown];

    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
}

-(void)testThatTextOnLabelIsEqualToTextOnButton {

    //mandamos un mensaje
    [self.simpleVC displayText:self.button];

    //comprobamos que se etiqueta con el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Boton y label deben tener el mismo texto");

}

-(void)testThatTableHasOneSection {

    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];

    XCTAssertEqual(sections, 1, @"Solo debe haber una seccion");
}

-(void)testThatNumberOfCellsIsNumberOfMoneysPlusOne {

    XCTAssertEqual(self.wallet.count + 1, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Numero de celdas = numero de moneys + 1");
}
@end
