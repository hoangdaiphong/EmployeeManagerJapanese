//
//  TableViewCell.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

// @synthesize sẽ tạo các phương thức getter và setter cho thuộc tính
@synthesize lblName;
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 8. Trong Cell set lblName là departmentName
- (void)setCellWithDepartment:(Department *)department atIndex:(nonnull NSIndexPath *)index {
    
    [lblName setText:[department departmentName]];
    
    //29 Gán currentCell là biến index hiện  
    currentCell = index;
}

//40 Truyền tên Employee vào text ở từng cell
- (void)setCellWithEmployee:(Employee *)employee atIndex:(NSIndexPath *)index {
    
    [lblName setText:[employee employeeName]];
    currentCell = index;
}

//27 Khi nhấn button delete thì nó sẽ gọi hàm xoá
- (IBAction)deleteCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellDeleteAtIndex:)]) {
        
        [delegate tableViewCellDeleteAtIndex:currentCell];
    }
}

// 32 Khi nhấn button edit thì nó sẽ gọi hàm sửa
- (IBAction)editCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellEditAtIndex:)]) {
        
        [delegate tableViewCellEditAtIndex:currentCell];
    }
}

@end
