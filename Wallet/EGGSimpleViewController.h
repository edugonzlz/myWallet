//
//  EGGSimpleViewController.h
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGGSimpleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)displayText:(id)sender;

@end
