//
//  Combo.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "CPComboBase.h"

@protocol ComboDelegate <NSObject>

@optional
/**
 * @brief 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param combo : 이벤트 발생한 Combo 를 리턴
 * @param text : 화면에 표시되는 값
 * @param data : data
 * @return nil
 */
- (void) combo:(CPComboBase *)combo text:(NSString *)text data:(NSString *)data;

/**
 * @brief 다중 선택 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param combo : 이벤트 발생한 Combo 를 리턴
 * @param datas : datas
 * @return nil
 */
- (void) combo:(CPComboBase *)combo datas:(NSMutableArray *)datas;

@end

@interface Combo2 : CPComboBase

@property (weak) id <ComboDelegate> comboDelegate;

@property (nonatomic, strong) NSString *selectedData;
@property (nonatomic, strong) NSMutableArray *selectedDatas;
@property (nonatomic) BOOL multiSelectEnable;
@property (nonatomic) NSInteger limitSelectCount;
@property (nonatomic, strong) NSString *tagString;

@end
