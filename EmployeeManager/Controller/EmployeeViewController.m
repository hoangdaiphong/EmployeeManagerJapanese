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

// Khai báo biến giống với file .h
@synthesize containView;
@synthesize tblEmployee;
@synthesize inputDepartment;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

//37 Thiết lập màn hình hiển thị Employee
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    // Thanh Navigation
    HeaderView *header = [[HeaderView alloc] init];
    [header setHeaderWithTitle:@"社員名" hideBack:NO hideAdd:NO inController:self];
    header.delegate = self;
    [self.view addSubview:header];
    
    // TableView Employee
    [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height)];
    [tblEmployee registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // Khai báo dataSource và delegate như ở file .
    tblEmployee.dataSource = self;
    tblEmployee.delegate = self;
    
    // Lấy dữ liệu mảng
    [self getData];
}

//36 Lấy dữ liệu Employee vào một Array
- (void)getData {
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[inputDepartment hasMany]allObjects]];
    
    [tblEmployee reloadData];
}

#pragma mark - HeaderView's Delegate

//38 Nhấn dấu cộng trên thanh header -> Chuyển qua màn hình 
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    // Khi YES bên view add sẽ thực hiện thêm Employee, nếu không set mặc định là NO thì màn hình view add thực hiện thêm Department
    addView.isEmployee = YES;
    
    addView.delegate = self;
    
    //43 Gán Department bên AddView trùng với Employee
    addView.inputDepartment = inputDepartment;
    
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma mark - AddViewController's Delegate

// Nếu add employee thành công thì sẽ get danh sách Employee
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if (success) {
        
        [self getData];
    }
}

#pragma mark - TableView's Delegate

//39 Cấu hình hiển thị data trên tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [employeeList count];    // Số section
}

//41 Truyền empoyeeName vào từng cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithEmployee:[employeeList objectAtIndex:indexPath.row] atIndex:indexPath];
    
    cell.delegate = self;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Xoá màu nền sau khi nhấn vào
    [self.tblEmployee deselectRowAtIndexPath:indexPath animated:YES];    
}

#pragma mark - TableViewCell's Delegate

//46 Hàm edit Employee khi ấn vào cell
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

//47 Hàm delete Employee khi ấn vào cell
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
