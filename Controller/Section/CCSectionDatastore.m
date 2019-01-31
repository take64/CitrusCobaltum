//
//  CCSectionDatastore.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/12.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCSectionDatastore.h"

#import "CCSectionItem.h"

#import "CFCollection.h"
#import "CFNVL.h"



@interface CCSectionDatastore()

//
// property
//
@property (nonatomic, retain) NSMutableArray<NSString *> *keys;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSMutableArray *> *objects;

@end



@implementation CCSectionDatastore

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        // 初期化
        [self empty];
    }
    return self;
}



#pragma mark - method
//
// method
//

// セクション数
- (NSUInteger) sectionCount
{
    return [[self keys] count];
}

// セクション内オブジェクト数
- (NSUInteger) countAtSection:(NSUInteger)sectionIndex
{
    return [[self objectsAtSection:sectionIndex] count];
}

// セクションキー
- (NSString *) keyAtSection:(NSUInteger)sectionIndex
{
     return [[self keys] objectAtIndex:sectionIndex];
}

// キーの示すセクションインデックス
- (NSInteger) sectionIndexAtKey:(NSString *)key
{
    if ([[self keys] containsObject:key] == YES)
    {
        return [[self keys] indexOfObject:key];
    }
    return NSNotFound;
}

// セクション内オブジェクト(インデックス)
- (NSMutableArray *) objectsAtSection:(NSUInteger)sectionIndex
{
    NSString *key = [self keyAtSection:sectionIndex];
    return [self objectsAtKey:key];
}

// セクション内オブジェクト(キー)
- (NSMutableArray *) objectsAtKey:(NSString *)key
{
    NSMutableArray *inObjects = [[self objects] objectForKey:key];
    return [CFNVL compare:inObjects replace:[@[] mutableCopy]];
}

// IndexPathが示すオブジェクト
- (id) objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectsAtSection:[indexPath section]] objectAtIndex:[indexPath row]];
}

// オブジェクトの追加
- (void) addObject:(id)object key:(NSString *)key
{
    NSInteger sectionIndex = [self sectionIndexAtKey:key];
    // キーが示すセクションインデックスがあるかどうか
    if (sectionIndex == NSNotFound)
    {
        // ない場合は登録
        [[self keys] addObject:key];
        [[self objects] addEntriesFromDictionary:@{ key:[@[] mutableCopy] }];
    }
    
    // オブジェクトの追加
    NSMutableArray *inObjects = [self objectsAtKey:key];
    [inObjects addObject:object];
}

// セクションソート
- (void) sortSectionOfAscending:(BOOL)ascending
{
    [[self keys] sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        // 昇順ならそのまま返却
        if (ascending == YES)
        {
            return result;
        }
        // 降順なら逆に
        return (result == NSOrderedAscending ? NSOrderedDescending : NSOrderedAscending);
    }];
}

// セクション内オブジェクト
- (void) sortObjectsOfSorts:(NSArray<NSDictionary *> *)sorts
{
    // オブジェクトをそれぞれソート
    NSArray<NSString *> *keys = [[self objects] allKeys];
    for (NSString *key in keys)
    {
        NSMutableArray *inObjects = [self objectsAtKey:key];
        NSArray *sortedObjects = [CFCollection sortWithEntityArray:inObjects sort:sorts];
        [[self objects] setObject:[sortedObjects mutableCopy] forKey:key];
    }
}

// 初期化
- (void) empty
{
    [self setKeys   :[@[] mutableCopy]];
    [self setObjects:[@{} mutableCopy]];
}



#pragma mark - static method
//
// static method
//

// CFCoreDataRequestの結果から生成
+ (CCSectionDatastore *) sectionDatastoreWithEntities:(NSArray<NSManagedObject *> *)entities keyPath:(NSString *)keyPath ascending:(BOOL)ascending
{
    CCSectionDatastore *datastore = [[CCSectionDatastore alloc] init];
    
    // セクションに分けながら投入
    for (NSManagedObject *entity in entities)
    {
        NSString *key = [entity valueForKeyPath:keyPath];
        [datastore addObject:entity key:key];
    }
    
    // ソート
    [datastore sortSectionOfAscending:ascending];
    
    return datastore;
}

// CCSectionItemの配列から生成
+ (CCSectionDatastore *) sectionDatastoreWithItems:(NSArray<CCSectionItem *> *)items
{
    CCSectionDatastore *datastore = [[CCSectionDatastore alloc] init];
    
    // セクションに分けながら投入
    for (CCSectionItem *item in items)
    {
        [datastore addObject:item key:kSectionDatastoreGeneralKey];
    }
    
    return datastore;
}

@end
