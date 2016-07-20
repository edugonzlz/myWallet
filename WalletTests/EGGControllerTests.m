//
//  EGGControllerTests.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGSimpleViewController.h"

@interface EGGControllerTests : XCTestCase

@property (strong, nonatomic)EGGSimpleViewController *simpleVC;
@property (strong, nonatomic)UIButton *button;
@property (strong, nonatomic)UILabel *label;

@end

@implementation EGGControllerTests

- (void)setUp {
    [super setUp];

    self.simpleVC = [[EGGSimpleViewController alloc]initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola Mozoncillo" forState:UIControlStateNormal];
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;

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
@end
