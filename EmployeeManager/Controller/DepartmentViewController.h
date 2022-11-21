//
//  DepartmentViewController.h
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 二つヘッダファイル(ナビゲーション バーと追加画面)を追加する
#import "TableViewCell.h"
#import "HeaderView.h"
#import "AddViewController.h"

NS_ASSUME_NONNULL_BEGIN

// テーブル ビュー作成するため UITableViewDataSource と UITableViewDelegate ライブラリーを追加する
@interface DepartmentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate, AddViewControllerDelegate, TableViewCellDelegate>

// オブジェクト部署を含む dataList を作成
{
    NSMutableArray *dataList;
}

// talbeView部署を管理するUITableView -> ファイル xib のテーブル ビューへのマッピング
@property (nonatomic, weak) IBOutlet UITableView *tblDepartment;

// 画面の UI 全部を含む UIView
@property (nonatomic, weak) IBOutlet UIView *containView;

@end

NS_ASSUME_NONNULL_END
