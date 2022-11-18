//
//  ContentManager.m
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "ContentManager.h"
#import "AppDelegate.h"

@implementation ContentManager

//2 データの取得と送信を管理するシングルトンを作成する 
+ (ContentManager *)shareManager {
    
    static ContentManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[ContentManager alloc] init];
    });
    
    return manager;
}

- (NSManagedObjectContext *)getCurrentContext {
    
    AppDelegate *application = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    return application.persistentContainer.viewContext;
}

//3  部署をデータベースに追加
- (BOOL)insertDepartmentWithName:(NSString *)name {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    // 部署オブジェクトを作成し、「Department」というのテーブルを使用してデータベースにインサート
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:context];
    
    // Gán tên department
    department.departmentName = name;
    
    NSError *error = nil;
    
    if (![context save:&error])     return NO;
    else    return YES;
    
}

//31 データベースの部署を編集
- (BOOL)editDepartment:(Department *)department {
    
    if (department != nil) {
        
        NSManagedObjectContext *context = [self getCurrentContext];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            return NO;
        } else {
            
            return YES;
        }
    } else {
        
        return NO;
    }
}

//4 データベースの部署を削除
- (BOOL)deleteDepartment:(Department *)department {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    [context deleteObject:department];
    
    NSError *error = nil;
    
    if (![context save:&error])     return NO;
    else   return YES;
    
}

//5 データベース内の全部の部署を取得する
- (NSArray *)getAllDepartment {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    // 部署を取得するためのリクエストをコンストラクタ
    NSFetchRequest *request = [Department fetchRequest];
    
    // departmentName をアルファベット順に並べ替える
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"departmentName" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    // 配列(Array)で部署を取得する
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
    
}

#pragma mark - Table Employee

//42 データベースに社員を追加
- (BOOL)insertEmployeeWithName:(NSString *)employeeName inDepartment:(Department *)department {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    Employee *el = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    
    el.employeeName = employeeName;
    
    [department addHasManyObject:el];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return NO;
    } else {
        
        return YES;
    }
}

//44 データベースで社員を編集
- (BOOL)editEmployee:(Employee *)employee {
    
    if (employee != nil) {
        
        NSManagedObjectContext *context = [self getCurrentContext];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            return NO;
        } else {
            
            return YES;
        }
    } else {
        
        return NO;
    }
}

//45 データベースの社員を削除
- (BOOL)deleteEmployee:(Employee *)employee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    [context deleteObject:employee];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return NO;
    } else {
        
        return YES;
    }
}

// データベース内の全部の社員を取得する
- (NSArray *)getAllEmployee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Employee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeName" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
    
}

@end
