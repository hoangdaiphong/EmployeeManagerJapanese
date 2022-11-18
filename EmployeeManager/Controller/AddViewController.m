//
//  AddViewController.m
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

// ヘッダファイル内の対応する変数
@synthesize containView;
@synthesize delegate;
@synthesize txtName;
@synthesize editFlag;
@synthesize inputDepartment;
@synthesize btnSave;
@synthesize isEmployee;
@synthesize inputEmployee;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

//19 表示画面の設定
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    // boolean 変数 editFlag と変数 isEmployee に基づいて、Department、Employee を追加または編集する画面を構成
    if (editFlag) {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員情報を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputEmployee employeeName]];
            
            [btnSave setTitle:@"編集" forState:UIControlStateNormal];
        } else {
            
            [header setHeaderWithTitle:@"部署を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputDepartment departmentName]];
            
            [btnSave setTitle:@"編集" forState:UIControlStateNormal];
        }
    } else {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員を追加" hideBack:NO hideAdd:YES inController:self];
        } else {
            
            [header setHeaderWithTitle:@"部署を追加" hideBack:NO hideAdd:YES inController:self];
        }
        
        
    }
    
    header.delegate = self;
    
    [containView addSubview:header];
    
}

// boolean 変数 editFlag と変数 isEmployee に基づいて,データベースに部署か社員を編集、または挿入
- (IBAction)addAction:(id)sender {
    
    if ([[txtName text] length] > 0) {
        
        BOOL success;
        
        if (editFlag) {
            
            if (isEmployee) {
                
                //34 変更した社員名をアップデート
                inputEmployee.employeeName = [txtName text];
                
                success = [[ContentManager shareManager] editEmployee:inputEmployee];
            } else {
                
                inputDepartment.departmentName = [txtName text];
                
                success = [[ContentManager shareManager] editDepartment:inputDepartment];
            }
        } else {
            
            if (isEmployee) {
                
                success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text inDepartment:inputDepartment];
                
            } else {
                //21 新しい部署を追加→アップデート
                success = [[ContentManager shareManager] insertDepartmentWithName:txtName.text];
            }
        }
        
        if (delegate != nil && [delegate respondsToSelector:@selector(addViewControllerFinishWithSuccess:)]) {
            //22 部署画面を遷移
            [delegate addViewControllerFinishWithSuccess:success];
        }
    }
    //24 ボタンをタッチすると部署画面を遷移
    [self.navigationController popViewControllerAnimated:YES];
}


@end
