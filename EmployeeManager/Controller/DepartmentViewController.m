//
//  DepartmentViewController.m
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "DepartmentViewController.h"
#import "EmployeeViewController.h"

@interface DepartmentViewController ()

@end

@implementation DepartmentViewController

// @synthesize: プロパティの getter メソッドと setter メソッドを作成する
@synthesize tblDepartment;
@synthesize containView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // URL Database file:
//    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSLog(@"%@", dirPaths);
    [self setupView];
    
    [self parseJSON];
}

// JSON ------------------------------------------------------------------------------

- (void)parseJSON {
    
    // jsonファイルを見つける
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    // データを取る: JSON(String)
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    // エラーチェック変数
    NSError *jsonError;
    
    // データを取る ---- NSLog(@"%@", allKeys);
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    // NSArray を作成して部署配列を取得 ---- NSLog(@"%@", arrDepartmentJSON);
    NSArray *arrDepartmentJSON = [allKeys objectForKey:@"department"];
    
    // 配列を参照して、JSON からデータベースに部署を追加
    for (int i = 0; i < arrDepartmentJSON.count; i++) {
        
        // 部署配列の中にオブジェクトを取得するために NSDictionary を作成します ------ NSLog(@"%@", departmentJSON);
        NSDictionary *departmentJSON = arrDepartmentJSON[i];
        
        // NSArray を作成して、社員の配列を取得 ------ NSLog(@"%@", arrEmployeeJSON);
        NSArray *arrEmployeeJSON = [departmentJSON objectForKey:@"employee"];
        
        // オブジェクトのデータをキーで取得 ------ NSLog(@"%@", departmentNameJSON);
        NSString *departmentNameJSON = [departmentJSON objectForKey:@"departmentName"];
        
        // データベースに存在しない場合は、データベースに追加される
        if(![self checkDepartment:departmentNameJSON]) {
            
            // データベースに挿入
            [[ContentManager shareManager] insertDepartmentWithName:departmentNameJSON];
        }
        
        // 配列を参照して社員を JSON からデータベースに追加
        for (int j = 0; j < arrEmployeeJSON.count; j++) {
            
            // NSDictinary を作成して、配列 employeeの中にオブジェクトを取得します ----- NSLog(@"%@", employeeJSON);
            NSDictionary *employeeJSON = arrEmployeeJSON[j];
           
            // オブジェクトのデータをキーで取得 ------ NSLog(@"%@", employeeNameJSON);
            NSString *employeeNameJSON = [employeeJSON objectForKey:@"employeeName"];
            
            // データベースに存在しない場合は追加されます
            if(![self checkEmployee:employeeNameJSON]) {
                
                NSMutableArray *listDepartment = [[NSMutableArray alloc] init];

                [listDepartment addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];

                for (int m = 0; m < listDepartment.count; m++) {
                
                    Department *department = listDepartment[m];
                    
                    if(department.departmentName == departmentNameJSON) {
                       
                        // データベースに挿入
                        [[ContentManager shareManager] insertEmployeeWithName:employeeNameJSON inDepartment:department];
                    }
                    
                }
                
            }
        }
    }
    
    [self getData];

    
}

// データベースの中で部署名があるかどうかを確認
- (BOOL)checkDepartment:(NSString *)departmentName {

    NSMutableArray *listDepartment = [[NSMutableArray alloc] init];
    
    [listDepartment addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    for (int m = 0; m < listDepartment.count; m++) {
        
        Department *departmentObject = listDepartment[m];
        
        if ([departmentName isEqualToString:departmentObject.departmentName]) return YES;
            
    }
    
    return NO;
}

// データベースの中で社員名があるかどうかを確認
- (BOOL)checkEmployee:(NSString *)employeeName {

   NSMutableArray *listEmployee = [[NSMutableArray alloc] init];

   [listEmployee addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
    
   for (int n = 0; n < listEmployee.count; n++) {

       Employee *employeeObject = listEmployee[n];

       if ([employeeName isEqualToString:employeeObject.employeeName]) return YES;
       
   }

   return NO;
}

// ----------------------------------------------------------------------------

//15 画面が表示されようとしている
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 元のナビゲーション バーを非表示にする
    [self.navigationController setNavigationBarHidden:YES];
}

//7 画面の構成
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];   // layout containView

    //14 ヘッダー バーを構成する
    HeaderView *header = [[HeaderView alloc] init];
    [header setHeaderWithTitle:@"部署名" hideBack:YES hideAdd:NO inController:self];
    //17 部署画面を遷移するためdelegateに設定する
    header.delegate = self;
    [containView addSubview:header];    // ヘッダーをcontainViewに追加
    
    [tblDepartment setFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];     // layout tableView
    
    // セルの設定が完了したら、tableViewセルに貼り付ける
    [tblDepartment registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //25 dataSource と delegateを宣言する
    tblDepartment.dataSource = self;
    tblDepartment.delegate = self;
    
    [self getData];
}

//6 データベースから部署リストを取得する機能
- (void)getData {
    
    dataList = [[NSMutableArray alloc] init];
    
    // データベースからリストを取得 (PrefixHeader.pchで)
    [dataList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    [tblDepartment reloadData];
}

#pragma mark - TableView's delegate
//9 テーブルにはいくつのセクションがある
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataList count];
}

//10 セルを作成し、各データを各セルに追加
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblDepartment dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithDepartment:[dataList objectAtIndex:indexPath.row] atIndex:indexPath];
    
    //28 tableViewCellのdelegateに貼り付ける -> 編集と削除の管理
    cell.delegate = self;
    
    return cell;
}

//35 オンタッチでTableView社員画面に移動
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // タップ後に背景色を削除
    [self.tblDepartment deselectRowAtIndexPath:indexPath animated:YES];
    
    // 部署をタッチすると、その部署の社員の一覧画面に遷移
    EmployeeViewController *employeeView = [[EmployeeViewController alloc] init];
    
    employeeView.inputDepartment = [dataList objectAtIndex:indexPath.row];
    
    // 社員の一覧画面に遷移
    [self.navigationController pushViewController:employeeView animated:YES];
    
}

#pragma mark HeaderView's delegate
//18 追加画面に遷移
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    [self.navigationController pushViewController:addView animated:YES];
    
}

#pragma mark - Add View Delegate

// 23 データの追加が成功したら、部署リストを取得
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if(success) {
        
        [self getData];
    }
}

#pragma mark - TableViewCell's Delegate

//30 削除ボタン：部署を含むセルをタッチすると、データベースの中でその部署を削除
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] deleteDepartment:[dataList objectAtIndex:index.row]]) {
        
        [dataList removeObjectAtIndex:index.row];
        
        [tblDepartment beginUpdates];
        
        [tblDepartment deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tblDepartment endUpdates];
        
        [tblDepartment reloadData];
    }
}

//33 編集ボタン：部署を含むセルをタッチすると、編集画面を遷移
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    addView.editFlag = YES;
    
    addView.inputDepartment = [dataList objectAtIndex:index.row];
    
    [self.navigationController pushViewController:addView animated:YES];
}

@end



