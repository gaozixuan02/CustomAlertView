//
//  CustomAlert.h
//  CustomAlertView
//
//  Created by GaoChao on 2017/6/12.
//  Copyright © 2017年 GaoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlert;
//弹框类型
typedef NS_ENUM(NSInteger,CustomAlertType){

    kCustomAlertTypeText
};
//block回调
typedef void(^CustomAlertViewCompletionHandler)(BOOL isConfirm,CustomAlert *customAlert,NSString *para);
//代理回调
@protocol CustomAlertDelegate <NSObject>

-(void)confirmAction;
-(void)cancleAction;

@end

@interface CustomAlert : UIView
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, weak) id<CustomAlertDelegate> delegate;
-(id)initWithType:(CustomAlertType)type title:(NSString*)title image:(UIImage*)image content:(NSString*)content;
-(id)initWithBlock:(CustomAlertViewCompletionHandler)completionHandler type:(CustomAlertType)type title:(NSString*)title image:(UIImage*)image content:(NSString*)content;
-(void)show;
@end
