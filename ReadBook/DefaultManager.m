//
//  DefaultManager.m
//  ReadBook
//
//  Created by Ibokan on 13-4-16.
//  Copyright (c) 2013年 kangxv. All rights reserved.
//

#import "DefaultManager.h"
#import "Book.h"
#import "JSON.h"
#define kSQLiteURL [NSHomeDirectory() stringByAppendingFormat:@"/Documents/Model.sqlite"]
@interface DefaultManager()
- (NSManagedObjectContext * )_context;          //数据管理器
- (NSManagedObjectModel * )_model;              //数据模拟器
- (NSPersistentStoreCoordinator * )_coordinator;//数据连接器
- (void)_nsnotificationSave:(NSNotification *)notification;//通知保存
- (void)_insertData;
@end
@implementation DefaultManager
{
    NSManagedObjectModel * _model;
    NSManagedObjectContext * _context;
    NSPersistentStoreCoordinator * _coordinator;
    //是否为新数据
    BOOL                _isNew;
}
+(DefaultManager *)defaultManager
{
    static DefaultManager * _manager = nil;
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _manager = [[DefaultManager alloc]init];
    });
    return _manager;
}
- (id)init
{
    self = [super init];
    if (self) {
        //不是新数据 就保存
        _isNew = NO;
        //监听NSManagedObjectContext 发生变化
        [self _context];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_nsnotificationSave:) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
    }
    if (_isNew) {
        //是新数据就插入
        [self _insertData];
    }
    return self;
}
//ret?id=4172402
- (void)_insertData
{
                   NSString * strin  = @"df6df696f6339c461cccd5ca357c7172";
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.shupeng.com/hotbook?bookid=28/&length=10" ]];
    [request setValue:strin forHTTPHeaderField:@"User-Agent"];

  NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSDictionary * json = [_content JSONValue];
   
    NSArray * array = [json objectForKey:@"result"];
    NSLog(@"%@",array);
}
#pragma mark - private methods
- (NSManagedObjectContext *)_context
{
    if (_context) {
        return _context;
    }
    _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:[self _coordinator]];
    return _context;
}
- (NSPersistentStoreCoordinator *)_coordinator
{
    if (_coordinator) {
        return _coordinator;
    }
    _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self _model]];
    NSMutableDictionary * _option = [[NSMutableDictionary alloc]init];
    [_option setObject:@(YES) forKey:NSMigratePersistentStoresAutomaticallyOption];
    NSError * error;
    if (![[NSFileManager defaultManager]fileExistsAtPath:kSQLiteURL]) {
        _isNew = YES;
    }
    else{
        [[NSFileManager defaultManager]removeItemAtPath:kSQLiteURL error:nil];
        _isNew = YES;
    }
    if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:kSQLiteURL] options:_option error:&error]){
        abort();
    }
    return _coordinator;
}
- (NSManagedObjectModel *)_model
{
    if (_model) {
        return _model;
    }
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"]];
    return _model;
}
- (void)_nsnotificationSave:(NSNotification *)notification
{
    NSError * error = nil;
    if ([[self _context]hasChanges] && [[self _context]save:&error]) {
        NSLog(@"Un error %@ %@",error,[error userInfo]);
        abort();
    }
}
- (void)save
{
    [self _nsnotificationSave:nil];
}
@end
