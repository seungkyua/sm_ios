//
//  CPBaseViewController.h
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface CPBaseViewController : UIViewController

// viewController간 데이터 전달을 위한 속성
@property (nonatomic, strong) id data;
// child -> parent 의 접근을 위한 속성
@property (nonatomic, retain) IBOutlet CPBaseViewController *parent;

/**
 * @brief viewController간 데이터 전달 시 호출
 * @param data : 전달할 데이터
 * @param sender : 어디서 부터 호출된 것인지 분기처리를 위한 구분자
 * @return void
 */
-(void)setData:(id)data sender:(id)sender;

/**
 * @brief 컨트롤러나 네비게이션 컨트롤러 자체를 받아서 data를 set하고 화면이동
 * @param uiViewController : 이동할 UIViewController
 * @param uiNavigationController : 이동할 UIViewController
 * @param data : 전달할 데이터
 * @return void
 */
-(void)moveSubViewController:(CPBaseViewController *)uiViewController :(UINavigationController *)uiNavigationController setData:(id) data;

/**
 * @brief 스토리보드명과 ID를 받아서 화면 이동
 * @param storyboardName : 스토리보드명
 * @param storyboardId : 스토리보드ID
 * @param data : 전달할 데이터
 * @return void
 */
-(void)moveSubViewController:(NSString *) storyboardName storyboardId:(NSString *)storyboardId setData:(id) data ;

/**
 * @brief segue로 화면이동
 * @param segueIdentifier : segue Identifier
 * @param data : 전달할 데이터
 * @return void
 */
-(void)moveSubViewController:(NSString *) segueIdentifier setData:(id) data;

/**
 * @brief 다음 화면이 네비게이션 컨트롤러를 상속받지 않는 PopupView일 경우 화면이동
 * @param uiViewController : 이동할 UIViewController
 * @param uiNavigationController : 이동할 UIViewController
 * @param data : 전달할 데이터
 * @return void
 */
-(void)movePopupViewController:(CPBaseViewController *)uiViewController :(UINavigationController *)uiNavigationController setData:(id) data;

/**
 * @brief 다음 화면이 네비게이션 컨트롤러를 상속받지 않는 PopupView일 경우 화면이동
 * @param storyboardName : 스토리보드명
 * @param storyboardId : 스토리보드ID
 * @param data : 전달할 데이터
 * @return void
 */
-(void)movePopupViewController:(NSString *) storyboardName storyboardId:(NSString *)storyboardId setData:(id) data;


/**
 * @brief 화면 닫기
 * @return void
 */
-(void)closeViewController;

@end
