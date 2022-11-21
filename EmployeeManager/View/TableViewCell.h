//
//  TableViewCell.h
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department+CoreDataClass.h"
#import "Employee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

// 編集か削除関数を呼び出すプロトコル
@protocol TableViewCellDelegate <NSObject>

// セルの削除・編集時のイベント管理機能
@optional
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index;
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index;
@end

// 現在のセル管理
@interface TableViewCell : UITableViewCell {
    
    NSIndexPath *currentCell;
}

// UILabel: xib ファイルのラベルを管理 (社員名と部署名)
@property (nonatomic, weak) IBOutlet UILabel *lblName;

// デリゲート変数を作成して削除か編集関数を呼び出す
@property (nonatomic, weak) id<TableViewCellDelegate>delegate;

// 部署と社員のデータをセルに送信する関数
- (void)setCellWithDepartment:(Department *)department atIndex:(NSIndexPath *)index;
- (void)setCellWithEmployee:(Employee *)employee atIndex:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
