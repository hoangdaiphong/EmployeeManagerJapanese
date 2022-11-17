//
//  HeaderView.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Trường hợp class này muốn thực thi một method của class khác  -> sử dụng protocol
@protocol HeaderViewDelegate <NSObject>

// @optional là kiểu không bắt buộc, hàm chuyển màn hình nhập Department
@optional
- (void)headerViewPushRightAction;

@end

@interface HeaderView : UIView

// Quản lý các UI bên file xib
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnAdd;

// Quản lý chuyển màn hình khi ấn back
@property (nonatomic, weak) UIViewController *currentController;

// Biến để thực hiện việc chuyển màn hình
@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

// Thiết lập cấu hình trên thanh Navigation bar
- (void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
