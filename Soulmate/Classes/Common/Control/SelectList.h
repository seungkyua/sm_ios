//
//  SelectList.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 23..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Canape/Canape.h>
#import "CommonUtil.h"

@class SelectList;
@protocol SelectListDelegate <NSObject>

@optional
/**
 * @brief 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param selectList : 이벤트 발생한 SelectList 를 리턴
 * @param text : 화면에 표시되는 값
 * @param data : data
 * @return nil
 */
- (void) selectList:(SelectList *)selectList text:(NSString *)text data:(NSString *)data;

/**
 * @brief 다중 선택 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param selectList : 이벤트 발생한 SelectList 를 리턴
 * @param datas : datas
 * @return nil
 */
- (void) selectList:(SelectList *)selectList datas:(NSMutableArray *)datas;

@end

@interface SelectList : UIControl <UITableViewDelegate, UITableViewDataSource>

@property (weak) id <SelectListDelegate> delegate;

@property (nonatomic) BOOL multiSelectEnable;
@property (nonatomic) NSInteger limitSelectCount;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSString *selectedData;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) UITableView *tableView;

- (NSMutableArray *) getSelectedDatas;
- (void) setSelectedWithDatas:(NSMutableArray *) datas;

@end
