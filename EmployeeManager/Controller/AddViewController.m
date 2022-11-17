//
//  AddViewController.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

// Các biến tương ứng bên file .h
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

//19 Cấu hình màn hình hiển thị
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    // Cấu hình màn hình thêm hoặc sửa Department, Employee dựa vào biến boolean editFlag và biến isEmployee
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

// Sửa hoặc thêm vào database Department hoặc Employee dựa theo editFlag và isEmployee
- (IBAction)addAction:(id)sender {
    
    if ([[txtName text] length] > 0) {
        
        BOOL success;
        
        if (editFlag) {
            
            if (isEmployee) {
                
                //34 Cập nhật tên Employee mới sửa
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
                //21 Thực hiện việc add Department
                success = [[ContentManager shareManager] insertDepartmentWithName:txtName.text];
            }
        }
        
        if (delegate != nil && [delegate respondsToSelector:@selector(addViewControllerFinishWithSuccess:)]) {
            //22 Chuyển qua màn hình Department
            [delegate addViewControllerFinishWithSuccess:success];
        }
    }
    //24 Khi ấn nút thì chuyển sang màn hình Department
    [self.navigationController popViewControllerAnimated:YES];
}


@end
