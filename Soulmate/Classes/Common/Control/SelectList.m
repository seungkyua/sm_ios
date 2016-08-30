//
//  SelectList.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 23..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "SelectList.h"

#define leftMargin 50
#define rightMargin 50
#define topMargin 30
#define bottomMargin 30
#define rowHeight 40

@implementation SelectList

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        CGRect rect = CGRectMake(leftMargin, topMargin, frame.size.width - leftMargin - rightMargin, frame.size.height - topMargin - bottomMargin);
        _tableView = [[UITableView alloc] initWithFrame:rect];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectListCell"];
        
        [self addTarget:self action:@selector(onModalTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)setData:(NSMutableArray *)data {
    _data = data;
    
    // 데이터 개수에 따라 높이가 바뀜
    
    int maxCount = (self.frame.size.height - topMargin - bottomMargin) / rowHeight;
    CGFloat h;
    if (data.count < maxCount) {
        h = data.count * rowHeight;
    } else {
        h = maxCount * rowHeight;
    }
    
    CGRect rect = CGRectMake(_tableView.frame.origin.x, (self.frame.size.height - h) / 2, _tableView.frame.size.width, h);
    [_tableView setFrame:rect];
    
    [_tableView reloadData];
}

- (void) setMultiSelectEnable:(BOOL)multiSelectEnable {
    _multiSelectEnable = multiSelectEnable;
    
    [_tableView setAllowsMultipleSelection:multiSelectEnable];
}

- (void) setSelectedData:(NSString *)selectedData {
    _selectedData = selectedData;
    
    NSInteger index = [CommonUtil findIndexByData:selectedData InArray:_data];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

- (void) setSelectedWithDatas:(NSMutableArray *)datas {
    
    for (int i = 0; i < datas.count; i++) {
        NSInteger index = [CommonUtil findIndexByData:[datas objectAtIndex:i] InArray:_data];
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSMutableArray *)getSelectedDatas {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSIndexPath *indexPath in _tableView.indexPathsForSelectedRows) {
        [arr addObject:[_data objectAtIndex:indexPath.row]];
    }
    
    return arr;
}

//The event handling method
- (void)onModalTouch {
    [CPHelper closePopupView:self withType:POPUP_TYPE_CENTER];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"selectListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if([[tableView indexPathsForSelectedRows] containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    id rowData = [self.data objectAtIndex:indexPath.row];
    if ([rowData isKindOfClass:[NSMutableDictionary class]] || [rowData isKindOfClass:[NSMutableDictionary class]]) {
        [cell.textLabel setText:rowData[@"text"]];
    } else {
        [cell.textLabel setText:rowData];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell;
    
    cell = [tableView cellForRowAtIndexPath:path];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (!_multiSelectEnable) {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(selectList:text:data:)]) {
                id rowData = [_data objectAtIndex:path.row];
                if ([rowData isKindOfClass:[NSMutableDictionary class]] || [rowData isKindOfClass:[NSMutableDictionary class]]) {
                    [_delegate selectList:self text:[rowData objectForKey:@"text"] data:[rowData objectForKey:@"data"]];
                } else {
                    [_delegate selectList:self text:rowData data:rowData];
                }
            }
        } else {
            
            
            NSMutableArray *datas = [self getSelectedDatas];
            
            // 최대 선택 개수 초과시 리턴
            if (datas.count > _limitSelectCount) {
                [tableView deselectRowAtIndexPath:path animated:NO];
                cell.accessoryType = UITableViewCellAccessoryNone;
                return;
            }
            
            // 최대 선택 개수가 선택 되면 Delegate 호출
            if (datas.count == _limitSelectCount && _delegate != nil && [_delegate respondsToSelector:@selector(selectList:datas:)]) {
                [_delegate selectList:self datas:datas];
            }
        }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
