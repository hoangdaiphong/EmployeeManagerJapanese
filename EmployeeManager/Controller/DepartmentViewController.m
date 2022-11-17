//
//  DepartmentViewController.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "DepartmentViewController.h"
#import "EmployeeViewController.h"

@interface DepartmentViewController ()

@end

@implementation DepartmentViewController

// @synthesize sẽ tạo các phương thức getter và setter cho thuộc tính
@synthesize tblDepartment;
@synthesize containView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // URL Database:
//    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);

    [self setupView];
    
    [self parseJSON];
}
// JSON

- (void)parseJSON {
    
    // Tìm file json
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    // Lấy dữ liệu JSON(String)
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Kiểm tra lỗi
    NSError *jsonError;
    
    // Lấy dữ liệu ---- NSLog(@"%@", allKeys);
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    // Tạo NSArray lấy mảng department ---- NSLog(@"%@", arrDepartmentJSON);
    NSArray *arrDepartmentJSON = [allKeys objectForKey:@"department"];
    
    // Duyệt mảng thêm department từ JSON vào Database
    for (int i = 0; i < arrDepartmentJSON.count; i++) {
        
        // Tạo NSDictionary để lấy từng Object trong mảng department ------ NSLog(@"%@", departmentJSON);
        NSDictionary *departmentJSON = arrDepartmentJSON[i];
        
        // Tạo NSArray lấy mảng employee ------ NSLog(@"%@", arrEmployeeJSON);
        NSArray *arrEmployeeJSON = [departmentJSON objectForKey:@"employee"];
        
        // Lấy data trong Object theo key ------ NSLog(@"%@", departmentNameJSON);
        NSString *departmentNameJSON = [departmentJSON objectForKey:@"departmentName"];
        
        // Nếu không tồn tại trong Database thì sẽ thêm vào
        if(![self checkDepartment:departmentNameJSON]) {
            
            // Insert vào database
            [[ContentManager shareManager] insertDepartmentWithName:departmentNameJSON];
        }
        
        // Duyệt mảng thêm employee từ JSON vào Database
        for (int j = 0; j < arrEmployeeJSON.count; j++) {
            
            // Tạo NSDictinary để lấy từng Object trong mảng employee ----- NSLog(@"%@", employeeJSON);
            NSDictionary *employeeJSON = arrEmployeeJSON[j];
           
            // Lấy data trong Object theo key ------ NSLog(@"%@", employeeNameJSON);
            NSString *employeeNameJSON = [employeeJSON objectForKey:@"employeeName"];
            
            // Nếu không tồn tại trong Database thì sẽ thêm vào
            if(![self checkEmployee:employeeNameJSON]) {
                
//                Department *department = [[Department alloc] init];
//                department.departmentName = departmentNameJSON;
                NSMutableArray *listDepartment = [[NSMutableArray alloc] init];
                
                [listDepartment addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
                
                for (int m = 0; m < listDepartment.count; m++) {
                    
                    //Department *department = listDepartment[m];
                    Employee *employee = [[Employee alloc] init];
                    employee.employeeName = employeeNameJSON;
                    employee.inDepartment = listDepartment[m];
                    // Insert vào database
                    [[ContentManager shareManager] insertEmployeeWithName:employee.employeeName inDepartment:listDepartment[m]];
                }
                
            }
        }
        

    }
    [self getData];

    
}

// Kiểm tra xem trong database đã có Department Name chưa
- (BOOL)checkDepartment:(NSString *)departmentName {

    NSMutableArray *listDepartment = [[NSMutableArray alloc] init];
    
    [listDepartment addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    for (int m = 0; m < listDepartment.count; m++) {
        
        Department *departmentObject = listDepartment[m];
        
        if ([departmentName isEqualToString:departmentObject.departmentName]) return YES;
            
    }
    
    return NO;
}

// Kiểm tra xem trong database đã có Employee Name chưa
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

//15 Màn hình chuẩn bị xuất
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // Ẩn thanh Navigation gốc
    [self.navigationController setNavigationBarHidden:YES];
}

//7 Thiết lập cấu hình cho màn hình
- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];   // layout containView

    //14 Cấu hình thanh header
    HeaderView *header = [[HeaderView alloc] init];
    [header setHeaderWithTitle:@"部署名" hideBack:YES hideAdd:NO inController:self];
    //17 Gán delegate chuyển màn hình Department
    header.delegate = self;
    [containView addSubview:header];    // Thêm header vào containView
    
    [tblDepartment setFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];     // layout tableView
    
    // Sau khi Set cell xong gán vào tableView
    [tblDepartment registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //25 Khai báo dataSource và delegate
    tblDepartment.dataSource = self;
    tblDepartment.delegate = self;
    
    [self getData];
}

//6 Hàm lấy danh sách Department từ Database
- (void)getData {
    
    dataList = [[NSMutableArray alloc] init];
    
    // Gọi hàm lấy danh sách từ Database (thông qua PrefixHeader.pch)
    [dataList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    [tblDepartment reloadData];
}

#pragma mark - TableView's delegate
//9. Có bao nhiêu section trong Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataList count];
}

//10 Tạo cell và thêm từng data vào từng cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblDepartment dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithDepartment:[dataList objectAtIndex:indexPath.row] atIndex:indexPath];
    
    //28 Gán delegate của tableViewCell -> quản lý sửa và xoá
    cell.delegate = self;
    
    return cell;
}

//35 Khi nhấn vào chuyển đến TableView Employee
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Xoá màu nền sau khi nhấn vào
    [self.tblDepartment deselectRowAtIndexPath:indexPath animated:YES];
    
    // Khi bấm vào 1 bộ phận thì chuyển qua danh sách Nhân viên trong Bộ phận đó
    EmployeeViewController *employeeView = [[EmployeeViewController alloc] init];
    
    employeeView.inputDepartment = [dataList objectAtIndex:indexPath.row];
    
    // Chuyển đến màn hình Employee
    [self.navigationController pushViewController:employeeView animated:YES];
    
}

#pragma mark HeaderView's delegate
//18 Hàm thực hiện chuyển đến màn hình Add 
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    [self.navigationController pushViewController:addView animated:YES];
    
}

#pragma mark - Add View Delegate

// 23 Nếu thêm dữ liệu thành công thì lấy lại danh sách Department
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if(success) {
        
        [self getData];
    }
}

#pragma mark - TableViewCell's Delegate

//30 Xoá Department trong database khi ấn vào cell chứa department đó
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] deleteDepartment:[dataList objectAtIndex:index.row]]) {
        
        [dataList removeObjectAtIndex:index.row];
        
        [tblDepartment beginUpdates];
        
        [tblDepartment deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tblDepartment endUpdates];
        
        [tblDepartment reloadData];
    }
}

//33 Sửa Department trong database khi ấn vào cell chứa department đó
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    addView.editFlag = YES;
    
    addView.inputDepartment = [dataList objectAtIndex:index.row];
    
    [self.navigationController pushViewController:addView animated:YES];
}

@end



