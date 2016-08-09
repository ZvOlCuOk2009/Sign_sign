//
//  MainMenu.m
//  SingSign
//
//  Created by Luoyan on 9/6/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

#import "MainMenu.h"
#import "ListCell.h"
#import "AppDelegate.h"
#import "SignListView.h"
#import "ContactFormView.h"
#import "SignKindMenu.h"
#import "DataArray.h"
#import "DataModel.h"
#import "SignCell.h"
#import "PlaySign.h"

@interface MainMenu ()

@end

@implementation MainMenu
@synthesize strSearchSign;
@synthesize arrSearchedSigns;

@synthesize txtSeachBar;
@synthesize mainMenuTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_4) {

            } else if (IS_IPHONE_5) {
                self = [super initWithNibName:@"MainMenu" bundle:nibBundleOrNil];
            } else if (IS_IPHONE_6) {
                self = [super initWithNibName:@"MainMenu6" bundle:nibBundleOrNil];
            } else if (IS_IPHONE_6_PLUS) {
                self = [super initWithNibName:@"MainMenu6+" bundle:nibBundleOrNil];
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    strSearchSign = @"";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)findTypedSigns{
    WordRecord *wordRecord;
    
    arrSearchedSigns = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < [gDataArray.arrWordLists count]; i ++){
        wordRecord = [[WordRecord alloc]init];
        wordRecord = [gDataArray.arrWordLists objectAtIndex:i];
        
        NSRange rangeValue1 = [wordRecord.strEnglish rangeOfString:strSearchSign options:NSCaseInsensitiveSearch];
        NSRange rangeValue2 = [wordRecord.strArabic rangeOfString:strSearchSign options:NSCaseInsensitiveSearch];
        
        if ((rangeValue1.length > 0 && rangeValue1.location == 0) || (rangeValue2.length > 0 && rangeValue2.location == 0)){
            [arrSearchedSigns addObject:wordRecord];
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    strSearchSign = searchText;
    if (![strSearchSign isEqualToString:@""]){
        [self findTypedSigns];
    }

    [mainMenuTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [txtSeachBar resignFirstResponder];
    [mainMenuTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    strSearchSign = @"";
    txtSeachBar.text = @"";
    [txtSeachBar resignFirstResponder];
    [mainMenuTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([strSearchSign isEqualToString:@""]){
        return [gDataArray.arrMainMenus count];
    } else {
        return [arrSearchedSigns count];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [txtSeachBar resignFirstResponder];
    if ([strSearchSign isEqualToString:@""]){
        SignKindMenu *selectedSignKindView = [[SignKindMenu alloc]initWithNibName:@"SignKindMenu" bundle:nil];
        
        selectedSignKindView.intMainMenuId = indexPath.row + 1;
        
        [self.navigationController pushViewController:selectedSignKindView animated:YES];
    } else {
        PlaySign *playSign = [[PlaySign alloc]initWithNibName:@"PlaySign" bundle:nil];
        
        WordRecord* wordRecord = [[WordRecord alloc]init];
        
        wordRecord = [arrSearchedSigns objectAtIndex:indexPath.row];
        
        playSign.intSubId = wordRecord.intSubId;
        playSign.intWordId = indexPath.row + 1;
        playSign.intTotalList = [arrSearchedSigns count];
        playSign.arrGroupSignInfo = arrSearchedSigns;
        
        [self.navigationController pushViewController:playSign animated:YES];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([strSearchSign isEqualToString:@""]){
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_4) {
                
            } else if (IS_IPHONE_5) {
                return [self dequeueReusableCustomBigCellWithIdentifier:tableView identifier:@"ListCell" indexPath:indexPath];
            } else if (IS_IPHONE_6) {
                return [self dequeueReusableCustomBigCellWithIdentifier:tableView identifier:@"ListCell6" indexPath:indexPath];
            } else if (IS_IPHONE_6_PLUS) {
                return [self dequeueReusableCustomBigCellWithIdentifier:tableView identifier:@"ListCell6+" indexPath:indexPath];
            }
        }
    } else {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_4) {
                
            } else if (IS_IPHONE_5) {
                return [self dequeueReusableCustomLitleCellWithIdentifier:tableView identifier:@"SignCell" indexPath:indexPath];
            } else if (IS_IPHONE_6) {
                return [self dequeueReusableCustomLitleCellWithIdentifier:tableView identifier:@"SignCell6" indexPath:indexPath];
            } else if (IS_IPHONE_6_PLUS) {
                return [self dequeueReusableCustomLitleCellWithIdentifier:tableView identifier:@"SignCell6+" indexPath:indexPath];
            }
        }
    }
    
    return nil;
}


- (ListCell *)dequeueReusableCustomBigCellWithIdentifier:(UITableView *)tableView
                                           identifier:(NSString *)identifier
                                            indexPath:(NSIndexPath *)indexPath
{
    ListCell *listCell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    listCell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] objectAtIndex:0];
    
    MainMenuRecord *mainMenuRecord = [[MainMenuRecord alloc]init];
    mainMenuRecord = [gDataArray.arrMainMenus objectAtIndex:indexPath.row];
    
    listCell.lblEnglishMenuString.text = mainMenuRecord.strMenuEnglish;
    listCell.lblArabicMenuString.text = mainMenuRecord.strMenuArabic;
    [listCell.imgMenuIcon setImage:[UIImage imageNamed:mainMenuRecord.strMenuIcon] forState:0];
    
    [listCell.lblEnglishMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblEnglishMenuString.font.pointSize]];
    [listCell.lblArabicMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblArabicMenuString.font.pointSize]];
    
    return listCell;
}


- (SignCell *)dequeueReusableCustomLitleCellWithIdentifier:(UITableView *)tableView
                                           identifier:(NSString *)identifier
                                            indexPath:(NSIndexPath *)indexPath
{
    SignCell *signCell = (SignCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    signCell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] objectAtIndex:0];
    WordRecord* wordRecord = [[WordRecord alloc]init];
    wordRecord = [arrSearchedSigns objectAtIndex:indexPath.row];
    
    signCell.lblWord.text = [NSString stringWithFormat:@"%@(%@)", wordRecord.strEnglish, wordRecord.strArabic];
    [signCell.lblWord setFont:[UIFont fontWithName:@"GEFlow-Bold" size:signCell.lblWord.font.pointSize]];
    
    return signCell;
}

- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    int rowHeight = 0;
    
    if ([[UIScreen mainScreen]bounds].size.height <= 568) {
        
        if ([strSearchSign isEqualToString:@""])
        {
            rowHeight = 96;
        } else {
            rowHeight = 43;
        }
    } else if (IS_IPHONE_6) {
        
        if ([strSearchSign isEqualToString:@""])
        {
            rowHeight = 114;
        } else {
            rowHeight = 51;
        }
    } else if (IS_IPHONE_6_PLUS) {
        
        if ([strSearchSign isEqualToString:@""])
        {
            rowHeight = 125;
        } else {
            rowHeight = 56;
        }
    }
    
    return rowHeight;
}

- (IBAction)sendMailFormLoad:(id)sender{
    ContactFormView *contactFormView = [[ContactFormView alloc]initWithNibName:@"ContactFormView" bundle:nil];
    [self presentViewController:contactFormView animated:YES completion:nil];
}

- (IBAction)favouriteListLoad:(id)sender{
    SignListView *signListView = [[SignListView alloc]initWithNibName:@"SignListView" bundle:nil];
    signListView.intSubMenuId = -1;
    [self.navigationController pushViewController:signListView animated:YES];
}

@end
