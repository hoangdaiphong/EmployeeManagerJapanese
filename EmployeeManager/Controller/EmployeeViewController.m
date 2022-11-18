//
//  EmployeeViewController.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/07.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController

// ヘッダファイル内の対応する変数
@synthesize containView;
@synthesize tblEmployee;
@synthesize inputDepartment;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
}

//37 社員画面の表示を設定
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    // ナビゲーションバー
    HeaderView *header = [[HeaderView alloc] init];
    [header setHeaderWithTitle:@"社員名" hideBack:NO hideAdd:NO inController:self];
    header.delegate = self;
    [self.view addSubview:header];
    
    // テーブルビューの社員
    [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height)];
    [tblEmployee registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // dataSource と delegateを宣言する
    tblEmployee.dataSource = self;
    tblEmployee.delegate = self;
    
    // 配列データを取得する
    [self getData];
}

//36 社員データを配列に取得する
- (void)getData {
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[inputDepartment hasMany]allObjects]];
    
//    [employeeList addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
    
    
    [tblEmployee reloadData];
    
}

#pragma mark - HeaderView's Delegate

//38 ヘッダーバーのプラスボタンをタッチすると -> 画面遷移
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    // YESとしたらう追加画面で社員を挿入する、じゃなかったらNOをそのまますると追加画面で部署を挿入する
    addView.isEmployee = YES;
    
    addView.delegate = self;
    
    //43 社員画面の部署と追加画面の部署が同じするため
    addView.inputDepartment = inputDepartment;
    
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma mark - AddViewController's Delegate

// 社員の追加が成功すると、社員リストが取得される
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if (success) {
        
        [self getData];
    }
}

#pragma mark - TableView's Delegate

//39 テーブル ビューでデータ表示の構成

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [employeeList count];    // いくつセクション
}

//41 各セルにempoyeeNameを渡す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithEmployee:[employeeList objectAtIndex:indexPath.row] atIndex:indexPath];
    
    cell.delegate = self;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // タップ後に背景色を削除
    [self.tblEmployee deselectRowAtIndexPath:indexPath animated:YES];    
}

#pragma mark - TableViewCell's Delegate

//46 セルにタッチすすと社員が編集される関数を読む
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] editEmployee:[employeeList objectAtIndex:index.row]]) {
        
        AddViewController *addView = [[AddViewController alloc] init];
        
        addView.isEmployee = YES;
        addView.editFlag = YES;
        addView.delegate = self;
        addView.inputEmployee = [employeeList objectAtIndex:index.row];
        
        [self.navigationController pushViewController:addView animated:YES];
    }
}

//47 セルにタッチすすと社員が削除される関数を読む
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] deleteEmployee:[employeeList objectAtIndex:index.row]]) {
        
        [employeeList removeObjectAtIndex:index.row];
        [tblEmployee beginUpdates];
        [tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
        [tblEmployee endUpdates];
        [tblEmployee reloadData];
    }
}

@end
