//
//  HeaderView.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

// Các biến tương ứng với các UI
@synthesize lblTitle;
@synthesize btnAdd;
@synthesize btnBack;
@synthesize delegate;
@synthesize currentController;

//11. Hàm tạo HeaderView
- (instancetype)init {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

// 13. Tải từ kho lưu trữ trình tạo giao diện 
- (void)awakeFromNib {

    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
}

//12. Cấu hình HeaderView
- (void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(UIViewController *)controller {
    
    [lblTitle setText:title];   //Title
    
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height)];    //Layout
    
    // Cấu hình ẩn hiện button
    [btnAdd setHidden:hideAdd];
    [btnBack setHidden:hideBack];
    
    currentController = controller;
}

//16 Ánh xạ vào button add -> ấn vào button thoả mãn điều kiện sẽ thực hiện hàm headerViewPushRightAction
- (IBAction)addAction:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(headerViewPushRightAction)]) {
        
        [delegate headerViewPushRightAction];
    }
    
}

//20 Ánh xạ vào button back -> ấn vào button thoả mãn điều kiện sẽ thực hiện currentController -> Chuyển màn hình
- (IBAction)backAction:(id)sender {
    
    [currentController.navigationController popViewControllerAnimated:YES];
}

@end
