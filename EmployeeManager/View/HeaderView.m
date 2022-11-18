//
//  HeaderView.m
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

// UIに対応する変数
@synthesize lblTitle;
@synthesize btnAdd;
@synthesize btnBack;
@synthesize delegate;
@synthesize currentController;

//11 HeaderView コンストラクタ
- (instancetype)init {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

//13 インターフェイス ストレージからダウンロード
- (void)awakeFromNib {

    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
}

//12 HeaderView インターフェイスの設定
- (void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(UIViewController *)controller {
    
    [lblTitle setText:title];   //タイトル
    
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height)];    //レイアウト
    
    // ボタンの表示と非表示を設定する
    [btnAdd setHidden:hideAdd];
    [btnBack setHidden:hideBack];
    
    currentController = controller;
}

//16 追加ボタンをへマッピング -> 条件が合わせる場合にボタンをタッチするとheaderViewPushRightAction関数を実行される
- (IBAction)addAction:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(headerViewPushRightAction)]) {
        
        [delegate headerViewPushRightAction];
    }
    
}

//20 バックボタンをへマッピング -> 条件が合わせる場合にボタンをタッチすると現在のテーブルビューを実行される -> 画面を遷移
- (IBAction)backAction:(id)sender {
    
    [currentController.navigationController popViewControllerAnimated:YES];
}

@end
