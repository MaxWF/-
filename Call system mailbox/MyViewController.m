//
//  MyViewController.m
//  Call system mailbox
//
//  Created by Max on 2019/3/11.
//  Copyright © 2019 吴凡. All rights reserved.
//

#import "MyViewController.h"
#import <MessageUI/MFMailComposeViewController.h>


@interface MyViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];
	
}

- (IBAction)btnClick:(id)sender {
	
	BOOL canSend = [MFMailComposeViewController canSendMail];
	if (canSend) {
		
		[self sendEmailAction];
		
	}else{
		
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未绑定邮箱" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
		[alert addAction:action];
		[self presentViewController:alert animated:YES completion:nil];
		
	}
	
}

- (void)sendEmailAction{
	
	// 邮件服务器
	MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
	// 设置邮件代理
	[mailVC setMailComposeDelegate:self];
	// 设置邮件主题
	[mailVC setSubject:@"邮件主题"];
	// 设置收件人
	[mailVC setToRecipients:@[@"349560277@qq.com"]];
	// 设置抄送人
	[mailVC setCcRecipients:@[@"349560277@qq.com"]];
	// 设置密抄送
	[mailVC setBccRecipients:@[@"349560277@qq.com"]];
	// 设置邮件的正文内容
	NSString *emailContent = @"邮件内容";
	// 是否为HTML格式
	[mailVC setMessageBody:emailContent isHTML:NO];
	
	[self presentViewController:mailVC animated:YES completion:nil];
	
}

#pragma MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
	
	switch (result)
	{
		case MFMailComposeResultCancelled: // 用户取消编辑
			NSLog(@"取消编辑");
			break;
		case MFMailComposeResultSaved: // 用户保存邮件
			NSLog(@"保存邮件");
			break;
		case MFMailComposeResultSent: // 用户点击发送
			NSLog(@"发送邮件");
			break;
		case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
			NSLog(@"操作报错: %@...", [error localizedDescription]);
			break;
	}
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
