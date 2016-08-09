//
//  SignKindMenu.m
//  SingSign
//
//  Created by Luoyan on 9/7/14.
//  Copyright (c) 2014 AcerBest. All rights reserved.
//

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

#import "SignKindMenu.h"
#import "ListCell.h"
#import "SignListView.h"
#import "AppDelegate.h"
#import "DataArray.h"
#import "DataModel.h"
#import "RamsahView.h"

@interface SignKindMenu ()

@end

@implementation SignKindMenu

@synthesize lblSignKindArabicTitle;
@synthesize lblSignKindEnglishTitle;
@synthesize intMainMenuId;
@synthesize intSubMenuId;
@synthesize arrSignKindPageContents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_4) {
                
            } else if (IS_IPHONE_5) {
                self = [super initWithNibName:@"SignKindMenu" bundle:nibBundleOrNil];
            } else if (IS_IPHONE_6) {
                self = [super initWithNibName:@"SignKindMenu6" bundle:nibBundleOrNil];
            } else if (IS_IPHONE_6_PLUS) {
                self = [super initWithNibName:@"SignKindMenu6+" bundle:nibBundleOrNil];
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setPageInfo];
    [self setFontFamily];
    
}

- (void)setFontFamily{
    [lblSignKindArabicTitle setFont:[UIFont fontWithName:@"GEFlow-Bold" size:lblSignKindArabicTitle.font.pointSize]];
    lblSignKindEnglishTitle.font = [UIFont fontWithName:@"GEFlow-Bold" size:lblSignKindEnglishTitle.font.pointSize];
}

- (void)setPageInfo{
    arrSignKindPageContents = [[NSMutableArray alloc]init];
    SubMenuRecord *submenuRecord;
    
    for (int i = 0 ; i < [gDataArray.arrSubMenus count] ; i ++){
        submenuRecord = [[SubMenuRecord alloc]init];
        submenuRecord = [gDataArray.arrSubMenus objectAtIndex:i];
        
        if (intMainMenuId == submenuRecord.intMainId){
            [arrSignKindPageContents addObject:submenuRecord];
        }
    }
    
    MainMenuRecord *mainMenuRecord = [[MainMenuRecord alloc]init];
    mainMenuRecord = [gDataArray.arrMainMenus objectAtIndex:intMainMenuId - 1];
    
    lblSignKindArabicTitle.text = mainMenuRecord.strMenuArabic;
    lblSignKindEnglishTitle.text = mainMenuRecord.strMenuEnglish;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrSignKindPageContents count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubMenuRecord* subMenuRecord = [[SubMenuRecord alloc]init];
    subMenuRecord = [arrSignKindPageContents objectAtIndex:indexPath.row];
    
    if ([lblSignKindEnglishTitle.text isEqualToString:@"About Ramsah"]){
        RamsahView *ramsahView = [[RamsahView alloc] initWithNibName:@"RamsahView" bundle:nil];
        
        ramsahView.intSubId = subMenuRecord.intSubId;
        
        [self.navigationController pushViewController:ramsahView animated:YES];
    } else {
        SignListView *signListView = [[SignListView alloc] initWithNibName:@"SignListView" bundle:nil];
         
        signListView.intSubMenuId = subMenuRecord.intSubId;
        
        [self.navigationController pushViewController:signListView animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    return nil;
}


- (ListCell *)dequeueReusableCustomBigCellWithIdentifier:(UITableView *)tableView
                                              identifier:(NSString *)identifier
                                               indexPath:(NSIndexPath *)indexPath
{
    ListCell *listCell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    listCell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] objectAtIndex:0];
    
    SubMenuRecord* subMenuRecord = [[SubMenuRecord alloc]init];
    
    subMenuRecord = [arrSignKindPageContents objectAtIndex:indexPath.row];
    
    listCell.lblArabicMenuString.text = subMenuRecord.strSubArabic;
    listCell.lblEnglishMenuString.text = subMenuRecord.strSubEnglish;
    [listCell.imgMenuIcon setImage:[UIImage imageNamed:subMenuRecord.strSubIcon] forState:0];
    
    [listCell.lblEnglishMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblEnglishMenuString.font.pointSize]];
    [listCell.lblArabicMenuString setFont:[UIFont fontWithName:@"GEFlow-Bold" size:listCell.lblArabicMenuString.font.pointSize]];
    
    return listCell;
}

- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    int rowHeight = 0;
    
    if ([[UIScreen mainScreen]bounds].size.height <= 568) {
        rowHeight = 96;
    } else if ([[UIScreen mainScreen]bounds].size.height >= 667) {
        rowHeight = 114;
    }
    
    return rowHeight;
}

-(IBAction)returnBefore:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
