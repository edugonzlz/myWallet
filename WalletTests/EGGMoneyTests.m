//
//  EGGMoneyTests.m
//  Wallet
//
//  Created by Edu González on 16/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGMoney.h"

@interface EGGMoneyTests : XCTestCase

@end

@implementation EGGMoneyTests

-(void)testCurrencies {

    XCTAssertEqualObjects(@"EUR", [[EGGMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");

    XCTAssertEqualObjects(@"USD", [[EGGMoney dollarWithAmount:1] currency], @"The currency of dollars should be USD");
}

-(void)testMultiplication {

    // Creamos una clase con los valores conocidos para probarla
    EGGMoney *euro = [EGGMoney euroWithAmount: 5];
    EGGMoney *ten = [EGGMoney euroWithAmount:10];
    EGGMoney *total = [euro times:2];

    // Ejecutamos un test de igualdad
    XCTAssertEqualObjects(total, ten, @"5€ *2 deberia ser 10€");
    // podriamos comprobar mas cosas de lo mismo
}

-(void)testEquality {

    EGGMoney *five = [EGGMoney euroWithAmount:5];
    EGGMoney *ten = [EGGMoney euroWithAmount:10];
    EGGMoney *total = [five times:2];

    XCTAssertEqualObjects(ten, total, @"Objetos equivalentes deberian ser iguales");
    XCTAssertEqualObjects([EGGMoney dollarWithAmount:4], [[EGGMoney dollarWithAmount:2] times:2], @"Objetos equivalentes deberian ser iguales");
}

-(void)testDifferentCurrencies {

    EGGMoney *euro = [EGGMoney euroWithAmount:1];
    EGGMoney *dollar = [EGGMoney dollarWithAmount:1];

    XCTAssertNotEqualObjects(euro, dollar, @"Diferent currencies should not be equal");
}

-(void)testHash {

    EGGMoney *a = [EGGMoney euroWithAmount:2];
    EGGMoney *b = [EGGMoney euroWithAmount:2];

    XCTAssertEqual([a hash], [b hash], @"Objetos iguales deben tener el mismo hash");
    XCTAssertEqual([[EGGMoney dollarWithAmount:3] hash], [[EGGMoney dollarWithAmount:3] hash], @"Objetos iguales deben tener el mismo hash");
}

-(void)testAmountStorage {

    EGGMoney *euro = [EGGMoney euroWithAmount:2];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue], @"El valor recogido debe ser el mismo que el guardado");
    XCTAssertEqual(2, [[[EGGMoney dollarWithAmount:2] performSelector:@selector(amount)]integerValue], @"El valor recogido debe ser el mismo que el guardado");
#pragma clang diagnostic pop
    
}
// TODO: - Testear la suma de currencies distintas
-(void)testSimpleAddittion {

    XCTAssertEqualObjects([[EGGMoney dollarWithAmount:5] plus: [EGGMoney dollarWithAmount:5]],
                              [EGGMoney dollarWithAmount:10],
                              @"5$ +5$ = 10$");
}

-(void)testThatHashIsAmount {

    EGGMoney *one = [EGGMoney dollarWithAmount:1];

    XCTAssertEqual([one hash], 1, @"El hash debe ser lo mismo que el amount");
}

-(void)testDescription {

    EGGMoney *one = [EGGMoney dollarWithAmount:1];
    NSString *desc = @"<EGGMoney: USD 1>";

    XCTAssertEqualObjects(desc, [one description], @"la descripcion debe coincidir con la plantilla");
}

@end
