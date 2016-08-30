//
//  Combo.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  선택 리스트가 화면 중앙에 뜨는 콤보
//  데이터를 data, text 으로 구분지어 디스플레이 되는 문자열과 실제 값을 다르게 넣을 수 있다.
//  다중 선택 가능.
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
