//
//  EmployeeViewController.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/07.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department+CoreDataClass.h"
#import "HeaderView.h"
#import "AddViewController.h"
#import "TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate, AddViewControllerDelegate, TableViewCellDelegate> {
    // 社員リストを作成
    NSMutableArray *employeeList;
}

// xib ファイルのUIを管理
@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITableView *tblEmployee;

// DepartmentViewで部署をタッチするとその部署にinputDepartmentを貼り付ける、その部署で社員を全部読んで　→ TableViewで表示させる
@property (nonatomic, weak) Department *inputDepartment;

@end

NS_ASSUME_NONNULL_END
