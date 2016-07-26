//
//  CPBaseViewController.m
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

#import "CPBaseViewController.h"

@interface CPBaseViewController ()
@property (nonatomic, strong) id segueData;
@end

@implementation CPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setData:(id)data sender:(id)sender {
    [self setData:data];
}

-(void)moveSubViewController:(CPBaseViewController *)uiViewController :(UINavigationController *)uiNavigationController setData:(id) data {
    if (uiViewController == nil) {
        [self presentViewController:uiNavigationController animated:YES completion:NULL];
        uiViewController = [uiNavigationController.viewControllers objectAtIndex:0];
    }
    [uiViewController setData:data];
    [self showViewController:uiViewController sender:nil];
}

-(void)moveSubViewController:(NSString *) storyboardName storyboardId:(NSString *)storyboardId setData:(id) data {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    CPBaseViewController *uiViewController = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
    [uiViewController setData:data];
    
    [self showViewController:uiViewController sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CPBaseViewController class]]) {
        [(CPBaseViewController *) segue.destinationViewController setData:[self segueData]];
    }
}

-(void)moveSubViewController:(NSString *) segueIdentifier setData:(id) data {
    [self setSegueData:data];
    [self performSegueWithIdentifier:segueIdentifier sender:self];
    
}

-(void)movePopupViewController:(CPBaseViewController *)uiViewController :(UINavigationController *)uiNavigationController setData:(id) data {
    [uiViewController setData:data];
    [self showDetailViewController:uiViewController sender:nil];
}

-(void)movePopupViewController:(NSString *)storyboardName storyboardId:(NSString *)storyboardId setData:(id)data {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    CPBaseViewController *uiViewController = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
    [uiViewController setData:data];
    [self showDetailViewController:uiViewController sender:nil];
}

- (void) closeViewController {
    
}

@end
