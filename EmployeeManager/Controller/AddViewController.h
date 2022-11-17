//
//  AddViewController.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
// Thêm file .h
#import "HeaderView.h"
#import "Department+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN


@protocol AddViewControllerDelegate <NSObject>

// Thực hiện sau khi add Object thành công
@optional
- (void)addViewControllerFinishWithSuccess:(BOOL)success;

@end

@interface AddViewController : UIViewController <HeaderViewDelegate>    // Thêm HeaderViewDelegate quản lý chuyển màn hình

// Quản lý các UI bên file xib
@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITextField *txtName;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

// Biến check có phải là Edit hoặc Employee hay không
@property (nonatomic, assign) BOOL editFlag;
@property (nonatomic, assign) BOOL isEmployee;


@property (nonatomic, weak) Department *inputDepartment;
@property (nonatomic, weak) Employee *inputEmployee;

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
