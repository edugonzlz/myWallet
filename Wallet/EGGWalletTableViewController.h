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

#define EUR_SECTION 0
#define USD_SECTION 1


@interface EGGWalletTableViewController : UITableViewController

// TODO: - ver si necesito los dos inits
-(id)initWithModel:(EGGWallet *)model;

@end
