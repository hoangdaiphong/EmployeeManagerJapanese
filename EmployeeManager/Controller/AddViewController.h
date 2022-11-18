//
//  AddViewController.h
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
// file .hを追加
#import "HeaderView.h"
#import "Department+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN


@protocol AddViewControllerDelegate <NSObject>

// オブジェクトの追加に成功した後に実行
@optional
- (void)addViewControllerFinishWithSuccess:(BOOL)success;

@end

@interface AddViewController : UIViewController <HeaderViewDelegate>    // 画面遷移を管理するためHeaderViewDelegateを追加

// xib ファイルのUIを管理する
@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITextField *txtName;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

// チェック変数は Edit または Employee ですか?
@property (nonatomic, assign) BOOL editFlag;
@property (nonatomic, assign) BOOL isEmployee;


@property (nonatomic, weak) Department *inputDepartment;
@property (nonatomic, weak) Employee *inputEmployee;

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
