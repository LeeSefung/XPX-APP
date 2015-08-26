//
//  PhoneDirectory.m
//  YPX
//
//  Created by cnxpx on 15/8/25.
//  Copyright (c) 2015年 YPX. All rights reserved.
//

#import "PhoneDirectory.h"
#import <AddressBook/AddressBook.h>
#import "PhoneDirectoryTableViewCell.h"

@interface PhoneDirectory () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

//通讯录
@property (assign,nonatomic) ABAddressBookRef addressBook;
//通讯录所有人员
@property (strong,nonatomic) NSMutableArray *allPerson;
//tabView
@property (nonatomic, strong) UITableView *tableView;

//添加搜索框
@property (nonatomic, strong) UITextField *searchTextField;
//搜索框背景框
@property (nonatomic, strong) UIButton *rectButton;
//搜索按钮
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation PhoneDirectory

//由于在整个视图控制器周期内addressBook都驻留在内存中，所有当控制器视图销毁时销毁该对象
-(void)dealloc{
    
    if (self.addressBook!=NULL) {
        CFRelease(self.addressBook);
    }
    
    //移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdatePhoneDirectory" object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //请求访问通讯录并初始化数据
        [self requestAddressBook];
        //添加tableView
        [self addSubview:self.tableView];
        //添加搜索
        [self addSubview:self.searchTextField];
        //添加搜索栏边框
        [self addSubview:self.rectButton];
        //添加搜索按钮
        [self addSubview:self.searchButton];
    }
    return self;
}

#pragma mark - getter
//添加tableview
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = ({
            
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 35*LSRATIO, WindowsWidth, self.bounds.size.height - 35*LSRATIO)];
            view.dataSource = self;
            view.delegate = self;
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            view;
        });
    }
    return _tableView;
}

//添加搜索栏
- (UITextField *)searchTextField {
    
    if (!_searchTextField) {
        
        _searchTextField = ({
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20*LSRATIO, 8*LSRATIO, WindowsWidth - 65*LSRATIO, 19*LSRATIO)];
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
            textField;
        });
    }
    return _searchTextField;
}

//添加搜索框
- (UIButton *)rectButton {
    
    if (!_rectButton) {
        
        _rectButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5*LSRATIO, 2*LSRATIO, WindowsWidth - 10*LSRATIO, 31*LSRATIO)];
            button.layer.cornerRadius = 15.5*LSRATIO;
            button.layer.borderWidth = 0.5*LSRATIO;
            button.layer.borderColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1].CGColor;
            button.userInteractionEnabled = NO;
            button;
        });
    }
    return _rectButton;
}

//添加搜索按钮
- (UIButton *)searchButton {
    
    if (!_searchButton) {
        
        _searchButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowsWidth-40*LSRATIO, 7*LSRATIO, 21*LSRATIO, 21*LSRATIO)];
            button.backgroundColor = [UIColor yellowColor];
            [button addTarget:self action:@selector(searchButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _searchButton;
}

#pragma mark - UITableView数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allPerson.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identtityKey = @"myTableViewCellIdentityKey1";
    PhoneDirectoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identtityKey];
    if(cell == nil){
        
        cell=[[PhoneDirectoryTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    //取得一条人员记录
    ABRecordRef recordRef = (__bridge ABRecordRef)self.allPerson[indexPath.row];
    //取得记录中得信息
    NSString *firstName = (__bridge NSString *) ABRecordCopyValue(recordRef, kABPersonFirstNameProperty);//注意这里进行了强转，不用自己释放资源
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(recordRef, kABPersonLastNameProperty);
    NSLog(@"F:%@ L:%@", firstName, lastName);
    ABMultiValueRef phoneNumbersRef= ABRecordCopyValue(recordRef, kABPersonPhoneProperty);//获取手机号，注意手机号是ABMultiValueRef类，有可能有多条
    //    NSArray *phoneNumbers=(__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumbersRef);//取得CFArraryRef类型的手机记录并转化为NSArrary
    long count = ABMultiValueGetCount(phoneNumbersRef);
    //    for(int i=0;i<count;++i){
    //        NSString *phoneLabel= (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(phoneNumbersRef, i));
    //        NSString *phoneNumber=(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneNumbersRef, i));
    //        NSLog(@"%@:%@",phoneLabel,phoneNumber);
    //    }
    
#warning 未修改地址
    cell.nameAndAdressLabel.text = [NSString stringWithFormat:@"%@ %@  四川成都",firstName,lastName];
    cell.name = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    if (count>0) {
        cell.phoneNumberLabel.text=(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneNumbersRef, 0));
    }
    
    if(ABPersonHasImageData(recordRef)){//如果有照片数据
        
        NSData *imageData= (__bridge NSData *)(ABPersonCopyImageData(recordRef));
        cell.imageView.image=[UIImage imageWithData:imageData];
    }else{
        
        cell.imageView.image=[UIImage imageNamed:@"avatar"];//没有图片使用默认头像
    }
    //使用cell的tag存储记录id
    cell.tag = ABRecordGetRecordID(recordRef);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*LSRATIO;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        ABRecordRef recordRef=(__bridge ABRecordRef )self.allPerson[indexPath.row];
//        [self removePersonWithRecord:recordRef];//从通讯录删除
//        [self.allPerson removeObjectAtIndex:indexPath.row];//从数组移除
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];//从列表删除
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

#pragma mark - UITableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    self.isModify=1;
    //    self.selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    //    [self performSegueWithIdentifier:@"AddPerson" sender:self];
}


#pragma mark - 私有方法
/**
 *  请求访问通讯录
 */
-(void)requestAddressBook{
    
    //创建通讯录对象
    self.addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
    
    //请求访问用户通讯录,注意无论成功与否block都会调用
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error) {
        if (!granted) {
            NSLog(@"未获得通讯录访问权限！");
        }
        [self initAllPerson];
        
    });
    
    //添加打电话通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:@"UpdatePhoneDirectory" object:nil];
}

/**
 *  取得所有通讯录记录
 */
- (void)initAllPerson {
    
    //取得通讯录访问授权
    ABAuthorizationStatus authorization = ABAddressBookGetAuthorizationStatus();
    //如果未获得授权
    if (authorization != kABAuthorizationStatusAuthorized) {
        NSLog(@"尚未获得通讯录访问授权！");
        return ;
    }
    //取得通讯录中所有人员记录
    CFArrayRef allPeople= ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    self.allPerson = (__bridge NSMutableArray *)allPeople;
    
    NSLog(@"%@", self.allPerson);
    //释放资源
    CFRelease(allPeople);
    
    if (self.tableView != nil) {
        
        [self.tableView reloadData];
    }
}

#pragma mark - 搜索点击事件（要考虑键盘回收）

- (void)searchButtonPress:(UIButton *)sender {
    
    //搜索按钮
    NSLog(@"开始搜索");
    //回收键盘
    [self endEditing:YES];
    [self.searchTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEditing:YES];
    [self searchButtonPress:self.searchButton];
    //取消textField身份;
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
    
}

//点击textField外面的时候触发
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self endEditing:YES];
    //取消textField身份;
    [textField resignFirstResponder];
}

#pragma mark - 刷新tabView
- (void)updateTableView {
    
    [self requestAddressBook];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
