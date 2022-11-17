//
//  Department+CoreDataProperties.h
//  QuanLyNhanVien
//
//  Created by Hoang  Dai Phong on 2022/11/06.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *departmentName;
@property (nullable, nonatomic, retain) NSSet<Employee *> *hasMany;

@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addHasManyObject:(Employee *)value;
- (void)removeHasManyObject:(Employee *)value;
- (void)addHasMany:(NSSet<Employee *> *)values;
- (void)removeHasMany:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
