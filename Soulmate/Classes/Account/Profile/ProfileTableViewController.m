//
//  HomeTableViewController.m
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
#import <Canape/Canape.h>

#define CELL_TYPE_SUB_TITLE @"subTitle"
#define CELL_TYPE_IMAGE_VIEW @"imageView"
#define CELL_TYPE_TEXT_VIEW @"textView"
#define CELL_TYPE_TEXT_FIELD @"textField"
#define CELL_TYPE_COMBO @"combo"
#define CELL_TYPE_COMBO2 @"combo2"

@interface ProfileTableViewController () <CPActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ComboDelegate, AutoResizeTextViewDelegate>

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
    
    _tableData = [[NSMutableArray alloc] initWithArray:@[
        @{@"type" : CELL_TYPE_SUB_TITLE,
          @"name" : @"subTitle1",
          @"title" : NSLocalizedString(@"account.profile.sub.title1", nil),
          @"description" : NSLocalizedString(@"account.profile.sub.description1", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"nick",
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
        @{@"type" : CELL_TYPE_TEXT_VIEW},
        
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
          @"title" : NSLocalizedString(@"account.profile.university.title", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"graduate",
          @"title" : NSLocalizedString(@"account.profile.graduate.school.title", nil)},
        @{@"type" : CELL_TYPE_TEXT_FIELD,
          @"name" : @"companyName",
          @"title" : NSLocalizedString(@"account.profile.company.name.title", nil)},
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
          @"title" : NSLocalizedString(@"account.profile.body.style.title", nil)},
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
          @"title" : NSLocalizedString(@"account.profile.interest.style.title", nil)},
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
    _imageActionSheet = [[CPActionSheet alloc] initWithTitle:nil
                                  otherButtonTitleArray:@[NSLocalizedString(@"account.profile.face.actionsheet.title1", nil),
                                                          NSLocalizedString(@"account.profile.face.actionsheet.title2", nil),
                                                          NSLocalizedString(@"account.profile.face.actionsheet.title3", nil)]
                                      cancelButtonTitle:nil delegate:self];
    
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
        [subTitleCell.labelSubTitle setText:[rowData objectForKey:@"title"]];
        [subTitleCell.textDescription setText:[rowData objectForKey:@"description"]];
        
        cell = subTitleCell;
    } else if ([CELL_TYPE_IMAGE_VIEW isEqualToString:type]) {
        ProfileTableViewImageViewCell *imageViewCell = [tableView dequeueReusableCellWithIdentifier:@"imageViewCell" forIndexPath:indexPath];
        
        [imageViewCell.image setImage:_profile.faceImage ? _profile.faceImage : [UIImage imageNamed:@"defaultFace"]];
        
        cell = imageViewCell;
    } else if ([CELL_TYPE_TEXT_VIEW isEqualToString:type]) {
        ProfileTableViewTextViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:@"textViewCell" forIndexPath:indexPath];
        textViewCell.textView.textViewDelegate = self;
        [textViewCell.textView setScrollEnabled:NO];
        [textViewCell.textView setText:_profile.selfDesc];
        cell = textViewCell;
    } else if ([CELL_TYPE_TEXT_FIELD isEqualToString:type]) {
        ProfileTableViewTextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:@"textFieldCell" forIndexPath:indexPath];
        [textFieldCell.labelTitle setText:[rowData objectForKey:@"title"]];
        
        NSString *cellName = [rowData objectForKey:@"name"];
        if ([@"nick" isEqualToString:cellName]) {
            [textFieldCell.textField setText:_profile.nickName];
        }
        
        cell = textFieldCell;
    } else if ([CELL_TYPE_COMBO isEqualToString:type]) {
        ProfileTableViewComboCell *comboCell = [tableView dequeueReusableCellWithIdentifier:@"comboCell" forIndexPath:indexPath];
        [comboCell.labelTitle setText:[rowData objectForKey:@"title"]];
        
        NSString *cellName = [rowData objectForKey:@"name"];
        if ([@"sex" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.sex InArray:_sexData]];
            [comboCell.combo setData:_sexData];
        } else if ([@"age" isEqualToString:cellName]) {
            [comboCell.combo setValue:_profile.age];
            [comboCell.combo setData:_ageData];
        } else if ([@"area" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.area InArray:_areaData]];
            [comboCell.combo setData:_areaData];
        } else if ([@"lastSchool" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.lastSchool InArray:_lastSchoolData]];
            [comboCell.combo setData:_lastSchoolData];
        } else if ([@"job" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.job InArray:_jobData]];
            [comboCell.combo setData:_jobData];
        } else if ([@"income" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.income InArray:_incomeData]];
            [comboCell.combo setData:_incomeData];
        } else if ([@"bloodType" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.bloodType InArray:_bloodTypeData]];
            [comboCell.combo setData:_bloodTypeData];
        } else if ([@"smoking" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.smoking InArray:_smokingData]];
            [comboCell.combo setData:_smokingData];
        } else if ([@"drinking" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.drinking InArray:_drinkingData]];
            [comboCell.combo setData:_drinkingData];
        } else if ([@"religion" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.religion InArray:_religionData]];
            [comboCell.combo setData:_religionData];
        } else if ([@"marriage" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.marriage InArray:_marriageData]];
            [comboCell.combo setData:_marriageData];
        } else if ([@"bodyShape" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.bodyShape InArray:_bodyShapeData]];
            [comboCell.combo setData:_bodyShapeData];
        } else if ([@"bodyStyle" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.bodyStyle InArray:_bodyStyleData]];
            [comboCell.combo setData:_bodyStyleData];
        } else if ([@"bodyHeight" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.bodyHeight InArray:_bodyHeightData]];
            [comboCell.combo setData:_bodyHeightData];
        } else if ([@"matchingInterest" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.matchingInterest InArray:_matchingInterestData]];
            [comboCell.combo setData:_matchingInterestData];
        } else if ([@"matchingDate" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.matchingDate InArray:_matchingDateData]];
            [comboCell.combo setData:_lastSchoolData];
        } else if ([@"interestSex" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestSex InArray:_interestSexData]];
            [comboCell.combo setData:_areaData];
        } else if ([@"interestMarriage" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestMarriage InArray:_interestMarriageData]];
            [comboCell.combo setData:_interestMarriageData];
        } else if ([@"interestAgeGap" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestAgeGap InArray:_interestAgeGapData]];
            [comboCell.combo setData:_interestAgeGapData];
        } else if ([@"interestStyle" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestStyle InArray:_interestStyleData]];
            [comboCell.combo setData:_interestStyleData];
        } else if ([@"interestBodyHeight" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestBodyHeight InArray:_interestBodyHeightData]];
            [comboCell.combo setData:_interestBodyHeightData];
        } else if ([@"interestBodyWeight" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestBodyWeight InArray:_interestBodyWeightData]];
            [comboCell.combo setData:_interestBodyWeightData];
        } else if ([@"interestReligion" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestReligion InArray:_interestReligionData]];
            [comboCell.combo setData:_interestReligionData];
        } else if ([@"interestDrinking" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestDrinking InArray:_interestDrinkingData]];
            [comboCell.combo setData:_interestDrinkingData];
        } else if ([@"interestSmoking" isEqualToString:cellName]) {
            [comboCell.combo setValue:[CommonUtil findTextByData:_profile.interestSmoking InArray:_interestSmokingData]];
            [comboCell.combo setData:_interestSmokingData];
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
        return 88;
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *rowData = [_tableData objectAtIndex:indexPath.row];
    NSString *type = [rowData objectForKey:@"type"];
    
    if ([CELL_TYPE_IMAGE_VIEW isEqualToString:type]) {
        [_imageActionSheet show];
    }
}

- (void) changeHeightWithTextView:(AutoResizeTextView *)autoResizeTextView height:(double)height {
    _profile.selfDesc = autoResizeTextView.text;
    
    [self.tableView reloadData];
    
    [self performSelector:@selector(deleayMethod:)
               withObject:autoResizeTextView
               afterDelay:0.1];
}

- (void) deleayMethod:(UITextView *) textView {
    [textView becomeFirstResponder];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ComboDelegate

- (void) combo:(Combo *)combo text:(NSString *)text data:(NSString *)data {
    
    if ([combo.data isEqual:_sexData]) {
        _profile.sex = data;
    } else if ([combo.data isEqual:_bodyShapeData]) {
        _profile.bodyShape = data;
    } else if ([combo.data isEqual:_ageData]) {
        _profile.age = data;
    } else if ([combo.data isEqual:_bodyStyleData]) {
        _profile.bodyStyle = data;
    } else if ([combo.data isEqual:_bloodTypeData]) {
        _profile.bloodType = data;
    } else if ([combo.data isEqual:_lastSchoolData]) {
        _profile.lastSchool = data;
    } else if ([combo.data isEqual:_bodyHeightData]) {
        _profile.bodyHeight = data;
    } else if ([combo.data isEqual:_areaData]) {
        _profile.area = data;
    } else if ([combo.data isEqual:_smokingData]) {
        _profile.smoking = data;
    } else if ([combo.data isEqual:_drinkingData]) {
        _profile.drinking = data;
    } else if ([combo.data isEqual:_marriageData]) {
        _profile.marriage = data;
    } else if ([combo.data isEqual:_religionData]) {
        _profile.religion = data;
    } else if ([combo.data isEqual:_jobData]) {
        _profile.job = data;
    } else if ([combo.data isEqual:_incomeData]) {
        _profile.income = data;
    } else if ([combo.data isEqual:_matchingInterestData]) {
        _profile.matchingInterest = data;
    } else if ([combo.data isEqual:_matchingDateData]) {
        _profile.matchingDate = data;
    } else if ([combo.data isEqual:_interestSexData]) {
        _profile.interestSex = data;
    } else if ([combo.data isEqual:_interestMarriageData]) {
        _profile.interestMarriage = data;
    } else if ([combo.data isEqual:_interestAgeGapData]) {
        _profile.interestAgeGap = data;
    } else if ([combo.data isEqual:_interestAreaData]) {
        _profile.interestArea = data;
    } else if ([combo.data isEqual:_interestStyleData]) {
        _profile.interestStyle = data;
    } else if ([combo.data isEqual:_interestBodyHeightData]) {
        _profile.interestBodyHeight = data;
    } else if ([combo.data isEqual:_interestBodyWeightData]) {
        _profile.interestBodyWeight = data;
    } else if ([combo.data isEqual:_interestReligionData]) {
        _profile.interestReligion = data;
    } else if ([combo.data isEqual:_interestDrinkingData]) {
        _profile.interestDrinking = data;
    } else if ([combo.data isEqual:_interestSmokingData]) {
        _profile.interestSmoking = data;
    }
}
             
#pragma mark - FaceActionSheet

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
    
    _profile.faceImage = img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
