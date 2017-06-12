//
//  CustomAlert.m
//  CustomAlertView
//
//  Created by GaoChao on 2017/6/12.
//  Copyright © 2017年 GaoChao. All rights reserved.
//

#import "CustomAlert.h"

@implementation CustomAlert
{
    UIView *_coverView;
    UIView *_alertView;
    UIButton *_cancleButton;
    CustomAlertType _currentAlertType;
    CustomAlertViewCompletionHandler _completionHandler;
    UIImage *_currentImage;
    NSString *_currentContent;
    NSString *_title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithType:(CustomAlertType)type title:(NSString *)title image:(UIImage *)image content:(NSString *)content{
    if (self = [super init]) {
        _currentAlertType = type;
        _currentImage = image;
        _currentContent = content;
        _title = title;
        [self configUI];
    }

    return self;
}
-(id)initWithBlock:(CustomAlertViewCompletionHandler)completionHandler type:(CustomAlertType)type title:(NSString *)title image:(UIImage *)image content:(NSString *)content{
    if (self = [super init]) {
        _currentAlertType = type;
        _currentImage = image;
        _currentContent = content;
        _title = title;
        _completionHandler = completionHandler;
        [self configUI];
    }
    return self;
}
-(void)configUI{
    CGFloat kAlertHeight = 130;
    [self setFrame:[UIScreen mainScreen].bounds];
    _coverView = [[UIView alloc] initWithFrame:self.frame];
    [_coverView setBackgroundColor:[UIColor blackColor]];
    [_coverView setAlpha:0.5];
    [self addSubview:_coverView];
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, kAlertHeight)];
    switch (_currentAlertType) {
        case kCustomAlertTypeText:
        {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setFont:[UIFont systemFontOfSize:13]];
            label.numberOfLines = 0;
            CGSize rectSize = CGSizeZero;
            rectSize = [_currentContent boundingRectWithSize:CGSizeMake(250, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            [label setText:_currentContent];
            [label setFrame:CGRectMake(10, 20, rectSize.width, rectSize.height)];
            [_alertView addSubview:label];
            if (rectSize.height < 16) {
                kAlertHeight = 100;
                [_alertView setFrame:CGRectMake(0, 0, 270, kAlertHeight)];
            } else if (rectSize.height > 16 && rectSize.height < 32) {
                kAlertHeight = 115;
                [_alertView setFrame:CGRectMake(0, 0, 270, kAlertHeight)];
            }

        }
            break;
            
        default:
            break;
    }
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((_alertView.frame.size.width-40)/2, 0, 40, 25)];
    [title setText:_title];
    [title setTextColor:[UIColor blackColor]];
    [_alertView addSubview:title];
    [_alertView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [_alertView.layer setCornerRadius:6.0];
    [_alertView.layer setMasksToBounds:YES];
    [_alertView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_alertView];
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(270/2, kAlertHeight - 44, 270/2, 44)];
    [_confirmButton setBackgroundColor:[UIColor whiteColor]];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor colorWithRed:(float)74/255.0f green:(float)192/255.0f blue:(float)86/255.0f alpha:1.0] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
     [_alertView addSubview:_confirmButton];
    _cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kAlertHeight - 44, 270/2, 44)];
    [_cancleButton setBackgroundColor:[UIColor whiteColor]];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:(float)74/255.0f green:(float)192/255.0f blue:(float)86/255.0f alpha:1.0] forState:UIControlStateNormal];
    [_cancleButton addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancleButton];
}
-(void)confirm:(id)sender{
    //代理
    if (_delegate && [_delegate respondsToSelector:@selector(confirmAction)]) {
        [_delegate confirmAction];
    }
   //block
    if (_completionHandler) {
        _completionHandler(YES,self,nil);
    }
    _completionHandler = nil;
    [self removeFromSuperview];
}
-(void)cancle:(id)sender{
     //代理
    if (_delegate && [_delegate respondsToSelector:@selector(cancleAction)]) {
        [_delegate cancleAction];
    }
    //block
    if (_completionHandler) {
        _completionHandler(NO,self,nil);
    }
    _completionHandler = nil;
    [self removeFromSuperview];
}
-(void)show{

    [[UIApplication sharedApplication].keyWindow.subviews[0] addSubview:self];

}
@end
