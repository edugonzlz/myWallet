//
//  EGGWalletTableViewController.h
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGGWallet;
@class EGGBroker;

@interface EGGWalletTableViewController : UITableViewController

-(id)initWithModel:(EGGWallet *)model;

@end
