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
    static DefaultManager *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[DefaultManager alloc] init];
    });
    return s_manager;
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
    
    if (_isNew) {
        //是新数据就插入
        [self _insertData];
          }
    }
    return self;
}
/**
 玄幻奇幻 29
 武侠仙侠 30
 都市言情 31
 历史军事 32
 游戏竞技 33
 科幻灵异 34
 经典全本 35
 */
//ret?id=4172402
//网络加载数据
- (void)_insertData
{
     NSString * appKey  = @"df6df696f6339c461cccd5ca357c7172";
      NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://api.shupeng.com/hotbook?bookid=28/&length=24" ] ]];
    [request setValue:appKey forHTTPHeaderField:@"User-Agent"];
  NSData * data =   [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     NSString *_content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //json解析数据
    NSDictionary * json = [_content JSONValue];
    [_content release];
       NSArray * array = [json objectForKey:@"result"];
    
    if ([array count] == 0) {
        [self bookList];
        //网络失败
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(_requestData) userInfo:nil repeats:NO];
    }
    //获取成功就删除原有数据重新加载
//    NSMutableArray *_mutabA = [self bookList:bookid];
//       for (Book * mov in _mutabA)
//    {
//               [[self _context] deleteObject:mov];
//    }

    for (NSDictionary * _dic in array) {
        Book * book = [self book];
        book.name = [_dic objectForKey:@"name"];
        book.thumb = [_dic objectForKey:@"thumb"];
        book.iD = [_dic objectForKey:@"id"];
        book.url = [_dic objectForKey:@"url"];
        book.author = [_dic objectForKey:@"author"];
        book.intro = [_dic objectForKey:@"intro"];
        book.nick = [_dic objectForKey:@"nick"];
   
    }
}
//网络失败方法
- (void)_requestData
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"查看网络" delegate:self cancelButtonTitle:nil otherButtonTitles: @"确定",nil];
    [alert show];
    [alert release];
}
//获取一个book对象
- (Book *)book
{
    Book * book = [NSEntityDescription insertNewObjectForEntityForName:@"Book"inManagedObjectContext:[self _context]];
    [self save];
    return book;
}
//获取book列表
- (NSMutableArray *)bookList
{
        NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    NSArray * results = [[self _context]executeFetchRequest:request error:nil];

    return [NSMutableArray arrayWithArray:results];
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
    _coordinator = [[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self _model]]autorelease];
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
    [_option release];
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
    if ([[self _context]hasChanges] && ![[self _context] save:&error]) {
        NSLog(@"Un error %@ %@",error,[error userInfo]);
        abort();
    }
}
- (void)save
{
    [self _nsnotificationSave:nil];
}
- (void)dealloc
{
    [_context release];
    [_model release];
    [_coordinator release];
    [super dealloc];
}
@end
