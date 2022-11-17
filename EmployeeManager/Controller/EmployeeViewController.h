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
    // Tao list Employee
    NSMutableArray *employeeList;
}

// Quản lý UI bên file xib
@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITableView *tblEmployee;

// Bên DepartmentView nhấn vào một Bộ phận thì truyền nó vào inputDepartment, đọc Employee ở Department được chọn để hiển thị lên TableView
@property (nonatomic, weak) Department *inputDepartment;

@end

NS_ASSUME_NONNULL_END
