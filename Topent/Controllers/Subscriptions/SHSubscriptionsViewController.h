//
//  SHSubscriptionsViewController.h
//  Topent
//
//  Created by Shuaib Yunus on 12/04/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SHSubscriptionsViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;

- (IBAction)scholarshipsSubscribe:(UIButton *)sender;
- (IBAction)internshipsSubscribe:(UIButton *)sender;
- (IBAction)eventsSubscribe:(UIButton *)sender;

- (IBAction)buyProduct:(id)sender;
- (void)getProductInfo:(UIViewController *)viewController;

@end
