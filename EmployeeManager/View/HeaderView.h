//
//  HeaderView.h
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// このクラスが別のクラスのメソッドを実装したい場合 -> プロトコルを使用
@protocol HeaderViewDelegate <NSObject>

// @optional：強制がない　ー　別画面を遷移機能
@optional
- (void)headerViewPushRightAction;

@end

@interface HeaderView : UIView

// xib ファイル内で UI を管理する
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnAdd;

// 現在の画面を管理変数
@property (nonatomic, weak) UIViewController *currentController;

// 画面遷移の変数
@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

// ナビゲーション バーの表示を設定する
- (void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
