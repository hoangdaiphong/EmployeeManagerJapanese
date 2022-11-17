//
//  TableViewCell.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department+CoreDataClass.h"
#import "Employee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

// Protocol để gọi hàm sửa xoá
@protocol TableViewCellDelegate <NSObject>

// hàm quản lý sự kiện khi Delete và Edit từng Cell
@optional
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index;
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index;
@end

// Quản lý Cell hiện tại
@interface TableViewCell : UITableViewCell {
    
    NSIndexPath *currentCell;
}

// UILabel quản lý Label bên file xib (tên của Department và Emplooyee)
@property (nonatomic, weak) IBOutlet UILabel *lblName;

// tạo biến delegate để gọi hàm sửa xoá
@property (nonatomic, weak) id<TableViewCellDelegate>delegate;

// Hàm set Cell truyền dữ liệu Department và Employee
- (void)setCellWithDepartment:(Department *)department atIndex:(NSIndexPath *)index;
- (void)setCellWithEmployee:(Employee *)employee atIndex:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
