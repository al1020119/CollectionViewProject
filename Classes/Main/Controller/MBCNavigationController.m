//
//  MBCNavigationController.m
//  iCocosCollection
//
//  Created by iCocos on 16/7/31.
//  Copyright © 2016年 iCocos-Collection All rights reserved.
//

#import "MBCNavigationController.h"
#import "UIBarButtonItem+Item.h"
@interface MBCNavigationController ()

@end

@implementation MBCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    viewController.navigationItem.rightBarButtonItem  = [UIBarButtonItem barButtonItemWithImage:@"Search" highImage:@"Search_selected"  target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    

    [super pushViewController:viewController animated:animated];
}

-(void)pop
{
    [super popViewControllerAnimated:YES];
}
@end
