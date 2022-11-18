//
//  ContentManager.h
//  EmployeeManager
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

// NSObject ファイル 

#import <Foundation/Foundation.h>

// 二つヘッダファイルを追加
#import "Department+CoreDataClass.h"
#import "Employee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentManager : NSObject

+ (ContentManager *)shareManager;

// 部署のリクエスト
- (BOOL)insertDepartmentWithName:(NSString *)name;
- (BOOL)deleteDepartment:(Department *)department;
- (NSArray *)getAllDepartment;
- (BOOL)editDepartment:(Department *)department;

// 社員のリクエスト
- (BOOL)insertEmployeeWithName:(NSString *)employeeName inDepartment:(Department *)department;
- (BOOL)editEmployee:(Employee *)employee;
- (BOOL)deleteEmployee:(Employee *)employee;
- (NSArray *)getAllEmployee;

@end

NS_ASSUME_NONNULL_END
