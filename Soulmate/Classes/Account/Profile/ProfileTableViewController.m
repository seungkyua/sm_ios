//
//  ProfileTableViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 2..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ProfileTableViewComboCell.h"
#import "ProfileTableViewSubTitleCell.h"
#import "ProfileTableViewTextViewCell.h"
#import "ProfileTableViewImageViewCell.h"
#import "ProfileTableViewTextFieldCell.h"
#import "Profile.h"
#import "CommonUtil.h"
#import "ProfileTextDetailViewController.h"
#import <Canape/Canape.h>

#define CELL_TYPE_SUB_TITLE @"subTitle"
#define CELL_TYPE_IMAGE_VIEW @"imageView"
#define CELL_TYPE_TEXT_VIEW @"textView"
#define CELL_TYPE_TEXT_FIELD @"textField"
#define CELL_TYPE_COMBO @"combo"
#define CELL_TYPE_COMBO2 @"combo2"

@interface ProfileTableViewController () <ComboDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) Profile *profile;

@property (nonatomic, strong) UIImageView *imageFace;
@property (nonatomic, strong) CPActionSheet *imageActionSheet;
@property (nonatomic, strong) NSMutableArray *sexData;
@property (nonatomic, strong) NSMutableArray *ageData;
@property (nonatomic, strong) NSMutableArray *bodyShapeData;
@property (nonatomic, strong) NSMutableArray *bodyStyleData;
@property (nonatomic, strong) NSMutableArray *bloodTypeData;
@property (nonatomic, strong) NSMutableArray *lastSchoolData;
@property (nonatomic, strong) NSMutableArray *bodyHeightData;
@property (nonatomic, strong) NSMutableArray *areaData;
@property (nonatomic, strong) NSMutableArray *smokingData;
@property (nonatomic, strong) NSMutableArray *drinkingData;
@property (nonatomic, strong) NSMutableArray *marriageData;
@property (nonatomic, strong) NSMutableArray *religionData;
@property (nonatomic, strong) NSMutableArray *jobData;
@property (nonatomic, strong) NSMutableArray *incomeData;
@property (nonatomic, strong) NSMutableArray *matchingInterestData;
@property (nonatomic, strong) NSMutableArray *matchingDateData;
@property (nonatomic, strong) NSMutableArray *interestSexData;
@property (nonatomic, strong) NSMutableArray *interestMarriageData;
@property (nonatomic, strong) NSMutableArray *interestAgeGapData;
@property (nonatomic, strong) NSMutableArray *interestAreaData;
@property (nonatomic, strong) NSMutableArray *interestStyleData;
@property (nonatomic, strong) NSMutableArray *interestBodyHeightData;
@property (nonatomic, strong) NSMutableArray *interestBodyWeightData;
@property (nonatomic, strong) NSMutableArray *interestReligionData;
@property (nonatomic, strong) NSMutableArray *interestDrinkingData;
@property (nonatomic, strong) NSMutableArray *interestSmokingData;
@property (nonatomic, strong) NSDictionary *addrData;

@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Table Layout 설정. name은 Profile의 속성명이랑 같아야 함
    _tableData = [[NSMutableArray alloc] initWithArray:@[
        @{@"type" : CELL_TYPE_SUB_TITLE,
          @"name" : @"subTitle1",
          @"title" : NSLocalizedString(@"account.profile.sub.title1", nil),
          @"description" : NSLocalizedString(@"account.profile.sub.description1", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"nick",
          @"limit" : @20,   // 최대 바이트 수
          @"title" : NSLocalizedString(@"account.profile.nick.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"sex",
          @"title" : NSLocalizedString(@"account.profile.sex.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"age",
          @"title" : NSLocalizedString(@"account.profile.age.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"area",
          @"title" : NSLocalizedString(@"account.profile.area.title", nil)},
        
        @{@"type" : CELL_TYPE_SUB_TITLE,
          @"name" : @"subTitle2",
          @"title" : NSLocalizedString(@"account.profile.sub.title2", nil),
          @"description" : NSLocalizedString(@"account.profile.sub.description2", nil)},
        @{@"type" : CELL_TYPE_TEXT_VIEW,
          @"name" : @"selfDesc",
          @"title" : NSLocalizedString(@"account.profile.self.desc.title", nil),
          @"limit" : @100},
        
        @{@"type" : CELL_TYPE_SUB_TITLE,
          @"name" : @"subTitle3",
          @"title" : NSLocalizedString(@"account.profile.sub.title3", nil),
          @"description" : NSLocalizedString(@"account.profile.sub.description3", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"name",
          @"title" : NSLocalizedString(@"account.profile.name.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"lastSchool",
          @"title" : NSLocalizedString(@"account.profile.last.school.title", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"university",
          @"title" : NSLocalizedString(@"account.profile.university.title", nil),
          @"autoComplete" : @"Y"},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"graduate",
          @"title" : NSLocalizedString(@"account.profile.graduate.school.title", nil),
          @"autoComplete" : @"Y"},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"companyName",
          @"title" : NSLocalizedString(@"account.profile.company.name.title", nil),
          @"autoComplete" : @"Y"},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"job",
          @"title" : NSLocalizedString(@"account.profile.job.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"income",
          @"title" : NSLocalizedString(@"account.profile.income.title", nil)},
        
        @{@"type" : CELL_TYPE_SUB_TITLE,
          @"name" : @"subTitle4",
          @"title" : NSLocalizedString(@"account.profile.sub.title4", nil),
          @"description" : NSLocalizedString(@"account.profile.sub.description4", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"bloodType",
          @"title" : NSLocalizedString(@"account.profile.blood.type.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"smoking",
          @"title" : NSLocalizedString(@"account.profile.smoking.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"drinking",
          @"title" : NSLocalizedString(@"account.profile.drinking.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"religion",
          @"title" : NSLocalizedString(@"account.profile.religion.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"marriage",
          @"title" : NSLocalizedString(@"account.profile.marriage.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"bodyShape",
          @"title" : NSLocalizedString(@"account.profile.body.shape.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"bodyStyle",
          @"title" : NSLocalizedString(@"account.profile.body.style.title", nil),
          @"multiSelectEnable" : @"Y",  // 다중 선택 허용
          @"limit" : @3},               // 최대 선택 개수
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"bodyHeight",
          @"title" : NSLocalizedString(@"account.profile.body.height.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"matchingInterest",
          @"title" : NSLocalizedString(@"account.profile.matching.interest.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"matchingDate",
          @"title" : NSLocalizedString(@"account.profile.matching.date.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestSex",
          @"title" : NSLocalizedString(@"account.profile.interest.sex.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestMarriage",
          @"title" : NSLocalizedString(@"account.profile.interest.marriage.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestAgeGap",
          @"title" : NSLocalizedString(@"account.profile.interest.age.gap.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestStyle",
          @"title" : NSLocalizedString(@"account.profile.interest.style.title", nil),
          @"multiSelectEnable" : @"Y",
          @"limit" : @3},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestBodyHeight",
          @"title" : NSLocalizedString(@"account.profile.interest.body.height.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestBodyWeight",
          @"title" : NSLocalizedString(@"account.profile.interest.body.weight.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestReligion",
          @"title" : NSLocalizedString(@"account.profile.interest.religion.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestDrinking",
          @"title" : NSLocalizedString(@"account.profile.interest.drinking.title", nil)},
        @{@"type" : CELL_TYPE_COMBO,
          @"name" : @"interestSmoking",
          @"title" : NSLocalizedString(@"account.profile.interest.smoking.title", nil)},
        ]];
    
    _profile = [[Profile alloc]init];
    
    // imageFace 터치 시 액션시트
//    _imageActionSheet = [[CPActionSheet alloc] initWithTitle:nil
//                                  otherButtonTitleArray:@[NSLocalizedString(@"account.profile.face.actionsheet.title1", nil),
//                                                          NSLocalizedString(@"account.profile.face.actionsheet.title2", nil),
//                                                          NSLocalizedString(@"account.profile.face.actionsheet.title3", nil)]
//                                      cancelButtonTitle:nil delegate:self];
    
    // 각 데이터 세팅
    
    _sexData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.sex.data", nil)];
    
    _ageData = [NSMutableArray array];
    for (int i = 1950; i < 2000; i++) {
        [_ageData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _smokingData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.smoking.data", nil)];
    _drinkingData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.drinking.data", nil)];
    _bodyShapeData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.body.shape.data", nil)];
    _bodyStyleData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.body.style.data", nil)];
    _bloodTypeData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.blood.type.data", nil)];
    _lastSchoolData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.last.school.data", nil)];
    _bodyHeightData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.body.height.data", nil)];
    _areaData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.area.data", nil)];
    _marriageData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.marriage.data", nil)];
    _religionData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.religion.data", nil)];
    _jobData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.job.data", nil)];
    _incomeData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.income.data", nil)];
    _matchingInterestData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.matching.interest.data", nil)];
    _matchingDateData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.matching.date.data", nil)];
    _interestSexData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.sex.data", nil)];
    _interestAreaData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.area.data", nil)];
    _interestStyleData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.style.data", nil)];
    _interestBodyHeightData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.body.height.data", nil)];
    _interestBodyWeightData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.body.weight.data", nil)];
    _interestAgeGapData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.age.gap.data", nil)];
    _interestSmokingData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.smoking.data", nil)];
    _interestDrinkingData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.drinking.data", nil)];
    _interestMarriageData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.marriage.data", nil)];
    _interestReligionData = [CommonUtil JsonStringToArray:NSLocalizedString(@"account.profile.interest.religion.data", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSMutableDictionary *rowData = [_tableData objectAtIndex:indexPath.row];
    NSString *type = [rowData objectForKey:@"type"];
    
    if ([CELL_TYPE_SUB_TITLE isEqualToString:type]) {
        ProfileTableViewSubTitleCell *subTitleCell = [tableView dequeueReusableCellWithIdentifier:@"subTitleCell" forIndexPath:indexPath];
        [subTitleCell.labelSubTitle setText:[NSString stringWithFormat:@"%@ :", [rowData objectForKey:@"title"]]];
        [subTitleCell.textDescription setText:[rowData objectForKey:@"description"]];
        
        cell = subTitleCell;
    } else if ([CELL_TYPE_IMAGE_VIEW isEqualToString:type]) {
        ProfileTableViewImageViewCell *imageViewCell = [tableView dequeueReusableCellWithIdentifier:@"imageViewCell" forIndexPath:indexPath];
        
        [imageViewCell.image setImage:_profile.faceImage ? _profile.faceImage : [UIImage imageNamed:@"defaultFace"]];
        
        cell = imageViewCell;
    } else if ([CELL_TYPE_TEXT_VIEW isEqualToString:type]) {
        ProfileTableViewTextViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:@"textViewCell" forIndexPath:indexPath];
//        textViewCell.textView.textViewDelegate = self;
        [textViewCell.textView setScrollEnabled:NO];
        [textViewCell.textView setText:_profile.selfDesc];
        cell = textViewCell;
    } else if ([CELL_TYPE_TEXT_FIELD isEqualToString:type]) {
        ProfileTableViewTextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:@"textFieldCell" forIndexPath:indexPath];
        [textFieldCell.labelTitle setText:[NSString stringWithFormat:@"%@ :", [rowData objectForKey:@"title"]]];
        
        NSString *cellName = [rowData objectForKey:@"name"];
        if ([@"nick" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.nickName];
        } else if ([@"name" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.name];
        } else if ([@"university" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.universityName];
        } else if ([@"graduate" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.graduateSchoolName];
        } else if ([@"companyName" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.companyName];
        }
        
        cell = textFieldCell;
    } else if ([CELL_TYPE_COMBO isEqualToString:type]) {
        ProfileTableViewComboCell *comboCell = [tableView dequeueReusableCellWithIdentifier:@"comboCell" forIndexPath:indexPath];
        [comboCell.labelTitle setText:[NSString stringWithFormat:@"%@ :", [rowData objectForKey:@"title"]]];
        [comboCell.combo setMultiSelectEnable:NO];
        
        NSString *cellName = [rowData objectForKey:@"name"];
        
        id data = [self valueForKey:[NSString stringWithFormat:@"%@Data", cellName]];
        id profileProp = [_profile valueForKey:cellName];
        
        [comboCell.combo setTagString:cellName];
        [comboCell.combo setData:data];
        
        if ([[rowData objectForKey:@"multiSelectEnable"] isEqualToString:@"Y"]) {
            NSMutableArray *datas = [NSMutableArray array];
            NSString *values = profileProp;
            for (int i = 0; i < values.length; i++) {
                [datas addObject:[NSString stringWithFormat: @"%C", [values characterAtIndex:i]]];
            }
            [comboCell.combo setMultiSelectEnable:YES];
            [comboCell.combo setSelectedDatas:datas];
            [comboCell.combo setLimitSelectCount:[[rowData objectForKey:@"limit"] intValue]];
        } else {
            [comboCell.combo setValue:[CommonUtil findTextByData:profileProp InArray:data]];
            [comboCell.combo setSelectedData:profileProp];
        }
        
        comboCell.combo.comboDelegate = self;
        
        cell = comboCell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *rowData = [_tableData objectAtIndex:indexPath.row];
    NSString *type = [rowData objectForKey:@"type"];
    
    if ([CELL_TYPE_SUB_TITLE isEqualToString:type]) {
        return UITableViewAutomaticDimension;
    } else if ([CELL_TYPE_IMAGE_VIEW isEqualToString:type]) {
        return UITableViewAutomaticDimension;
    } else if ([CELL_TYPE_TEXT_VIEW isEqualToString:type]) {
        return UITableViewAutomaticDimension;
    } else if ([CELL_TYPE_TEXT_FIELD isEqualToString:type]) {
        return UITableViewAutomaticDimension;
    } else if ([CELL_TYPE_COMBO isEqualToString:type]) {
        return UITableViewAutomaticDimension;
    } 
    return 44;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSMutableDictionary *rowData = [_tableData objectAtIndex:indexPath.row];
//    NSString *type = [rowData objectForKey:@"type"];
//    
//    if ([CELL_TYPE_IMAGE_VIEW isEqualToString:type]) {
//        [_imageActionSheet show];
//    }
//}
//
//- (void) changeHeightWithTextView:(AutoResizeTextView *)autoResizeTextView height:(double)height {
//    _profile.selfDesc = autoResizeTextView.text;
//    
//    [self.tableView reloadData];
//    
//    [self performSelector:@selector(deleayMethod:)
//               withObject:autoResizeTextView
//               afterDelay:0.1];
//}
//
//- (void) deleayMethod:(UITextView *) textView {
//    [textView becomeFirstResponder];
//}

#pragma mark - prepareForSegue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ProfileTextDetailViewController class]]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *type = [_tableData objectAtIndex:selectedIndexPath.row][@"name"];
        NSNumber *limit = [_tableData objectAtIndex:selectedIndexPath.row][@"limit"];
        NSString *title = [_tableData objectAtIndex:selectedIndexPath.row][@"title"];
        BOOL autoCompleteEnable = [@"Y" isEqualToString:[_tableData objectAtIndex:selectedIndexPath.row][@"autoComplete"]] ? YES: NO;
        
        ProfileTextDetailViewController *dest = segue.destinationViewController;
        [dest setProfile:_profile];
        [dest setTitle:title];
        [dest setAutoCompleteEnable:autoCompleteEnable];
        if (limit != nil) {
            [dest setLimitBytes:[limit intValue]];
        }
        [dest setType:type];
    }
}

#pragma mark - ComboDelegate

- (void) combo:(Combo2 *)combo text:(NSString *)text data:(NSString *)data {
    
    NSString *tag = combo.tagString;
    [_profile setValue:data forKey:tag];
}

- (void) combo:(Combo2 *)combo datas:(NSMutableArray *)datas {
    
    NSString *data = @"";
    for (int i = 0; i < datas.count; i++) {
        NSString *dataValue = [datas objectAtIndex:i][@"data"];
        data = [NSString stringWithFormat:@"%@%@", data, dataValue];
    }
    
    NSString *tag = combo.tagString;
    [_profile setValue:data forKey:tag];
}

#pragma mark - FaceActionSheet

//- (void) actionSheet:(CPActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    [imagePicker setDelegate:self];
//    [imagePicker setAllowsEditing:YES];
//    
//    if (buttonIndex == 0) {
//        // 앨범에서 선택
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    } else if (buttonIndex == 1) {
//        // 포스팅에서 불러오기
//    } else {
//        // 촬영으로 선택
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
//        
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//}
//
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    _profile.faceImage = img;
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.tableView reloadData];
//}
//
//- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)touchBtnSave:(id)sender {
    NSLog(@"%@", [_profile getProfileJsonString]);
}
@end
