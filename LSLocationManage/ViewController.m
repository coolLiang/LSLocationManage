//
//  ViewController.m
//  LSLocationManage
//
//  Created by noci on 16/6/15.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"
#import "LocationManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[LocationManage sharedManager]startUpdateLocationWith:^(NSString *address) {
        
        NSLog(@"%@",address);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
