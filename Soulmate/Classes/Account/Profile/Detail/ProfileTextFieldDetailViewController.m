//
//  ProfileTextViewDetailViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTextFieldDetailViewController.h"
#import <Canape/Canape.h>
#import "CommonUtil.h"

#define DEFAULT_HEIGHT 200

@interface ProfileTextFieldDetailViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *autoCompleteData;
@property (nonatomic, strong) NSMutableArray *searchData;

@end

@implementation ProfileTextFieldDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textField.delegate = self;
    
    [_textField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([@"nick" isEqualToString:self.type]) {
        [_textField setText:self.profile.nickName];
    } else if ([@"name" isEqualToString:self.type]) {
        [_textField setText:self.profile.name];
    } else if ([@"university" isEqualToString:self.type]) {
        [_textField setText:self.profile.universityName];
    } else if ([@"graduate" isEqualToString:self.type]) {
        [_textField setText:self.profile.graduateSchoolName];
    } else if ([@"companyName" isEqualToString:self.type]) {
        [_textField setText:self.profile.companyName];
    }
    
    [self highlightBtn];
    [_textField becomeFirstResponder];
    if (self.limitBytes == 0) {
        [_labelLimit setHidden:YES];
    } else {
        [self setTextLimit];
        [_labelLimit setHidden:NO];
    }
    
    if (self.autoCompleteEnable) {
        _autoCompleteData = [[NSMutableArray alloc] initWithArray:@[@"abc", @"bcd", @"apple", @"홍익대", @"강남대", @"서울대", @"연세대", @"고려대", @"용인대", @"이화여대", @"성신여대", @"중앙대", @"개불대"]];
        
        if (_tableView == nil) {
            CGRect rect = CGRectMake(0, _textField.frame.origin.y + _textField.frame.size.height, self.view.frame.size.width, DEFAULT_HEIGHT);
            _tableView = [[UITableView alloc]initWithFrame:rect];
            [_tableView setDelegate:self];
            [_tableView setDataSource:self];
            [self.view addSubview:_tableView];
            
            [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"autoCompleteCell"];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) highlightBtn {
    if ([_textField.text isEqualToString:@""]) {
        _btnComplete.enabled = NO;
    } else {
        _btnComplete.enabled = YES;
    }
}

- (void) setTextLimit {
    NSString *t = @"";
    NSUInteger bytes = [_textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    t = [NSString stringWithFormat:@"%lu / %ld bytes", (unsigned long)bytes, (long)self.limitBytes];
    [_labelLimit setText:t];
}

#pragma mark - UITextViewDelegate

- (void)textFieldDidChange {
    [self highlightBtn];
    [self setTextLimit];
    
    if (self.autoCompleteEnable) {
        _searchData = [NSMutableArray array];
        for (NSString *data in _autoCompleteData) {
            if ([CommonUtil matchString:data searchString:_textField.text]) {
// e           if ([data containsString:_textField.text]) {
                [_searchData addObject:data];
            }
        }
        
        [_tableView reloadData];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.limitBytes > 0) {
        return [_textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + ([string lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - range.length) <= self.limitBytes;
    } else {
        return YES;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"autoCompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[_searchData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_textField setText:[_searchData objectAtIndex:indexPath.row]];
    
    _searchData = [NSMutableArray array];
    [_tableView reloadData];
}

#pragma mark - Event Handler

- (IBAction)touchBtnComplete:(id)sender {
    if ([@"nick" isEqualToString:self.type]) {
        self.profile.nickName = self.textField.text;
    } else if ([@"name" isEqualToString:self.type]) {
        self.profile.name = self.textField.text;
    } else if ([@"university" isEqualToString:self.type]) {
        self.profile.universityName = self.textField.text;
    } else if ([@"graduate" isEqualToString:self.type]) {
        self.profile.graduateSchoolName = self.textField.text;
    } else if ([@"companyName" isEqualToString:self.type]) {
        self.profile.companyName = self.textField.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    
    CGFloat h = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGRect rect = _tableView.frame;
    rect.size.height = DEVICE_SIZE.height - rect.origin.y - h;
    [_tableView setFrame:rect];
    
    [_tableView reloadData];
}

@end
