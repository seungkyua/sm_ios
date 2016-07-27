//
//  ProfileViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileViewController.h"
#import <Canape/Canape.h>

@interface ProfileViewController () <CPActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CPComboBaseDelegate>

@property (nonatomic, strong) CPActionSheet *actionSheet;
@property (nonatomic, strong) NSDictionary *addrData;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // imageView 터치 설정
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchFace)];
    singleTap.numberOfTapsRequired = 1;
    [_imgFace setUserInteractionEnabled:YES];
    [_imgFace addGestureRecognizer:singleTap];
    
    // imageFace 터치 시 액션시트
    _actionSheet = [[CPActionSheet alloc] initWithTitle:nil
                                  otherButtonTitleArray:@[NSLocalizedString(@"account.profile.face.actionsheet.title1", nil),
                                                          NSLocalizedString(@"account.profile.face.actionsheet.title2", nil),
                                                          NSLocalizedString(@"account.profile.face.actionsheet.title3", nil)]
                                      cancelButtonTitle:nil delegate:self];
    
    // 성별 콤보
    [_comboSex setPlaceholder:@"선택하세요"];
    [_comboSex setParent:self.view];
    [_comboSex setPlaceholderLabelColor:[UIColor grayColor]];
    [_comboSex setData:[NSMutableArray arrayWithArray:@[NSLocalizedString(@"account.profile.sex.male", nil),
                                                       NSLocalizedString(@"account.profile.sex.female", nil)]]];
    
    // 생년월일 콤보
    [_comboBirth setPlaceholder:@"선택하세요"];
    [_comboBirth setComboType:COMBO_TYPE_DATE_YMD];
    [_comboBirth setParent:self.view];
    [_comboBirth setPlaceholderLabelColor:[UIColor grayColor]];
    
    // 주소 데이터
    NSString *addr = NSLocalizedString(@"account.profile.addr.data", nil);
    NSError* error;
    _addrData = [NSJSONSerialization
                          JSONObjectWithData:[addr dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          error:&error];
    // check ERROR
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
    NSMutableArray *addr1 = [NSMutableArray array];
    for (NSDictionary *addrData in _addrData) {
        NSString *value = addrData[@"name"];
        
        [addr1 addObject:value];
    }
    
    // 주소 시/도 콤보
    [_comboAddr1 setData:addr1];
    [_comboAddr1 setPlaceholder:@"시/도"];
    [_comboAddr1 setParent:self.view];
    [_comboAddr1 setDelegate:self];
    [_comboAddr1 setPlaceholderLabelColor:[UIColor grayColor]];
    
    // 주소 시/군/구 콤보
    [_comboAddr2 setPlaceholder:@"시/군/구"];
    [_comboAddr2 setParent:self.view];
    [_comboAddr2 setPlaceholderLabelColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - FaceActionSheet

- (void) touchFace {
    [_actionSheet show];
}

- (void) actionSheet:(CPActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    
    if (buttonIndex == 0) {
        // 앨범에서 선택
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        // 포스팅에서 불러오기
    } else {
        // 촬영으로 선택
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _imgFace.image = img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AddrCombo Delegate

- (void) combo:(CPComboBase *)combo value:(NSString *)_value {
    NSMutableArray *addr2 = [NSMutableArray array];
    for (NSDictionary *addrData in _addrData) {
        NSString *value = addrData[@"name"];
        
        if ([value isEqualToString:_value]) {
            addr2 = addrData[@"children"];
        }
    }
    
    [_comboAddr2 setData:addr2];
    
    [_comboAddr2 setValue:@""];
}

#pragma mark - touchButton

@end
