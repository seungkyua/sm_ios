//
//  CPUIUtils.m
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

#import "CPUIUtils.h"

@implementation CPUIUtils

+ (CGSize)sizeForTableView:(UITableView *)tableView{
    CGSize tableViewSize = CGSizeMake(0, 0);
    NSInteger numberOfSections = [tableView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++) {
        // Factor in the size of the section header
        CGRect rect = [tableView rectForHeaderInSection:section];
        tableViewSize = CGSizeMake(CGSizesMaxWidth(tableViewSize, rect.size), CGSizesAddHeights(tableViewSize, rect.size));
        
        // Factor in the size of the section
        rect = [tableView rectForSection:section];
        tableViewSize = CGSizeMake(CGSizesMaxWidth(tableViewSize, rect.size), CGSizesAddHeights(tableViewSize, rect.size));
        
        // Factor in the size of the footer
        rect = [tableView rectForFooterInSection:section];
        tableViewSize = CGSizeMake(CGSizesMaxWidth(tableViewSize, rect.size), CGSizesAddHeights(tableViewSize, rect.size));
    }
    return tableViewSize;
}




@end
