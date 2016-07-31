//
//  EGGWalletTableViewController.m
//  Wallet
//
//  Created by Edu González on 20/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

#import "EGGWalletTableViewController.h"
#import "EGGWallet.h"

@interface EGGWalletTableViewController ()

@property (strong, nonatomic)EGGWallet *model;

@end

@implementation EGGWalletTableViewController

-(id)initWithModel:(EGGWallet *)model {

    if (self = [super initWithStyle:UITableViewStylePlain]) {

        _model = model;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Devolver numero de divisas + 1
    return [self.model currenciesCount] +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Devolver numero de moneys +1 para cada seccion/divisa
    return [self.model moneysCountForCurrency:section] +1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EGGMoney *money = [self.model moneyForIndexPath:indexPath];

    static NSString *cellId = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {

        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }

    cell.textLabel.text = money.currency;
    cell.detailTextLabel.text = money.amount.stringValue;

    // Para la celda extra de la seccion, EL SUBTOTAL
    if (indexPath.row == [self.model moneysCountForCurrency:indexPath.section] ) {

        cell.textLabel.text = @"Subtotal";
        cell.detailTextLabel.text = [self.model subtotal:indexPath.section].amount.stringValue;
    }

    // Para la seccion extra, EL TOTAL
    if (indexPath.section == [self.model currenciesCount]) {

        cell.textLabel.text = @"Total EUR";
        cell.detailTextLabel.text = [self.model total].amount.stringValue;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section >= [self.model.currencies count]) {
        return @"TOTAL";
    }
    return [self.model rateNameForSection:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
