//
//  SHSubscriptionsViewController.m
//  Topent
//
//  Created by Shuaib Yunus on 12/04/2014.
//  Copyright (c) 2014 Shuaib Yunus. All rights reserved.
//

#import "SHSubscriptionsViewController.h"

@interface SHSubscriptionsViewController ()

@end

@implementation SHSubscriptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x00688B);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SKPaymentQueue defaultQueue]
     addTransactionObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)scholarshipsSubscribe:(UIButton *)sender {
    self.productID = @"scholarships";
    
    [self.navigationController
     pushViewController:self animated:YES];
    
    [self getProductInfo:self];
}

- (IBAction)internshipsSubscribe:(UIButton *)sender {
    
}

- (IBAction)eventsSubscribe:(UIButton *)sender {
    
}

-(void)getProductInfo:() viewController
{
    //    _homeViewController = viewController;
    
    if ([SKPaymentQueue canMakePayments]) {
        SKProductsRequest *request = [[SKProductsRequest alloc]
                                      initWithProductIdentifiers:
                                      [NSSet setWithObject:self.productID]];
        request.delegate = self;
        
        [request start];
    } else {
    //        _productDescription.text = @"Please enable In App Purchase in Settings";
    }
}

- (IBAction)buyProduct:(id)sender {
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)unlockFeature {
//    _buyButton.enabled = NO;
//    [_buyButton setTitle:@"Purchased"
//                forState:UIControlStateDisabled];
//    [_homeViewController enableLevel2];
}

#pragma mark SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSArray *products = response.products;
    
    if (products.count != 0) {
        _product = products[0];
//        _productTitle.text = _product.localizedTitle;
//        _productDescription.text = _product.localizedDescription;
    } else {
//        _productTitle.text = @"Product not found";
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products) {
        NSLog(@"Product not found: %@", product);
    }
}

#pragma mark SKPaymentTransactionObserver

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self unlockFeature];
                [[SKPaymentQueue defaultQueue]
                 finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue]
                 finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

@end
