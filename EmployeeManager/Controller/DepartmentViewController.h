//
//  DepartmentViewController.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

// Import 2 file bên View và AddViewController
#import "TableViewCell.h"
#import "HeaderView.h"
#import "AddViewController.h"

NS_ASSUME_NONNULL_BEGIN

// Thêm thư viện UITableViewDataSource và UITableViewDelegate để tạo Table View
@interface DepartmentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate, AddViewControllerDelegate, TableViewCellDelegate>

// Tạo dataList để chứa các Object Department
{
    NSMutableArray *dataList;
}

// UITableView để quản lý cho talbeView Department -> Ánh xạ vào Table View ở file xib
@property (nonatomic, weak) IBOutlet UITableView *tblDepartment;

// UIView để chứa toàn bộ UI của màn hình
@property (nonatomic, weak) IBOutlet UIView *containView;

@end

NS_ASSUME_NONNULL_END
