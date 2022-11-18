//
//  TableViewCell.m
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

// @synthesize: プロパティの getter メソッドと setter メソッドを作成する
@synthesize lblName;
@synthesize delegate;

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

//8 セルで、lblNameにdepartmentNameを送信する
- (void)setCellWithDepartment:(Department *)department atIndex:(nonnull NSIndexPath *)index {
    
    [lblName setText:[department departmentName]];
    
    //29 currentCell をパラメーターindexとして設定する
    currentCell = index;
}

//40 セルのテキストに社員名を送信する
- (void)setCellWithEmployee:(Employee *)employee atIndex:(NSIndexPath *)index {
    
    [lblName setText:[employee employeeName]];
    currentCell = index;
}

//27 削除ボタンが押されると、削除関数が呼び出される
- (IBAction)deleteCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellDeleteAtIndex:)]) {
        
        [delegate tableViewCellDeleteAtIndex:currentCell];
    }
}

//32 編集ボタンが押されると、編集関数が呼び出される
- (IBAction)editCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellEditAtIndex:)]) {
        
        [delegate tableViewCellEditAtIndex:currentCell];
    }
}

@end
