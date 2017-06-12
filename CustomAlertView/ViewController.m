//
//  ViewController.m
//  CustomAlertView
//
//  Created by GaoChao on 2017/6/12.
//  Copyright © 2017年 GaoChao. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlert.h"
@interface ViewController ()<CustomAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 65)/2, 100, 80, 65)];
    [btn setTitle:@"代理方式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 65)/2, 200, 80, 65)];
    [btn1 setTitle:@"block方式" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
   
}

- (void)clickBtn{
    
    CustomAlert *custom = [[CustomAlert alloc] initWithType:kCustomAlertTypeText title:@"注意" image:nil content:@"这是代理回调的方式！"];
    custom.delegate = self;
    [custom show];
    
}
-(void)clickBtn1{
    
    CustomAlert *custom = [[CustomAlert alloc] initWithBlock:^(BOOL isConfirm, CustomAlert *customAlert, NSString *para) {
        //
        if (isConfirm) {
            NSLog(@"block YES");
        }else{
            NSLog(@"block NO");
        }
    } type:kCustomAlertTypeText title:@"警告" image:nil content:@"这是block回调的方式！"];
    [custom show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)confirmAction{

    NSLog(@"delegate YES");
}
-(void)cancleAction{

    NSLog(@"delegate NO");


}
@end
