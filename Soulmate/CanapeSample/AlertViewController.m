//
//  AlertViewController.m
//  CanafeTest
//
//  Created by bliex on 2016. 2. 26..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "AlertViewController.h"
#import <Canape/Canape.h>

@interface AlertViewController () <CPAlertDelegate>
@property (nonatomic, strong) CPAlert *alert1;
@property (nonatomic, strong) CPAlert *alert2;
@property (nonatomic, strong) CPAlert *alert3;
@property (nonatomic, strong) CPAlert *alert4;
@property (nonatomic, strong) CPAlert *alert5;
@property (weak, nonatomic) IBOutlet UITextField *eventTestTextField;
@end

@implementation AlertViewController
@synthesize alert1;
@synthesize alert2;
@synthesize alert3;
@synthesize alert4;
@synthesize alert5;
@synthesize eventTestTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // alert 생성
    alert1 = [[CPAlert alloc] initWithTitle:@"대만 퓨처스 캠프서 순조로운 재활 ‘시즌 전력화’ 기대감, SK 미래 뜬다 [OSEN=타이중(대만), 김태우 기자]" contentText:@"지난 2월 12일 시작된 SK의 대만 퓨처스팀(2군) 전지훈련에 재활조로 참가한 두 선수는 더할 나위 없는 따뜻한 날씨 속에 순조롭게 재활 프로그램을 진행하고 있다. 김경기 SK 퓨처스팀 감독은 “재활조 선수들이 무난하게 페이스를 끌어올리고 있다”라며 반색했다. 2014년 SK의 1차 지명자인 이건욱은 입단 직후 팔꿈치인대접합수술(토미존 서저리)을 받았다. 1년 넘는 재활 기간을 이겨내고 마운드에 다시 섰으나 지난해 애리조나 교육리그 당시 발가락을 다쳐 다시 수술대에 올랐다. 수술 및 회복 기간 동안 공을 던지지 못해 1월 중순부터 다시 몸 상태를 끌어올리고 있다. 서진용은 지난해 6월 팔꿈치인대접합수술(토미존 서저리)을 받아 현재 재활 중이다. 현재 상태는 아주 좋다. 계획대로 착착 진행되고 있다. 이건욱은 현재 불펜에서 피칭 강도를 서서히 끌어올렸고 6일에는 첫 라이브 피칭을 한다. 팔꿈치 재활은 한참 전에 끝난 만큼 몸에는 별다른 문제가 없다. 이건욱은 “괜찮으면 전지훈련 마지막 턴 정도에는 실전 등판을 할 수 있을 것 같다”라고 조심스레 말했다. 1군의 결정이 필요하겠지만 현 추세라면 시범경기 막판 대기 자체는 가능하다. 아직은 터널 속에 있는 서진용의 표정도 밝다. 서진용은 현재 단계별투구프로그램(ITP)를 탈 없이 진행 중이다. 이미 50m 수준까지 왔다. 다시 10m 단계로 돌아가 개수를 늘리며 조금씩 팔꿈치에 힘을 주게 된다. 서진용은 “계획상 이번 캠프에서 ITP 단계를 모두 끝낼 계획”이라고 말했다. 예상보다 회복세가 빠르다. ITP 단계에서 흔히 있는 ‘후퇴’가 지금까지는 한 번도 없었다는 것 또한 고무적이다.재활이 예상대로 진행된다면 이건욱은 시즌 개막부터 실전에서 던질 수 있다. 당분간 2군에서 조정 기간이 필요하기는 하겠지만 건강한 상태로 시즌을 여는 것조차 오래간만이다. 의미 있는 일이다. 동산고 시절 고교를 평정한 투수였던 이건욱은 팀이 장기적인 에이스로 기대를 걸고 있는 재목이다. 구단에서는 절대 급하게 생각하지 않겠다는 생각이다. 육성총괄 시절 이건욱을 지켜봤던 김용희 SK 감독 또한 마찬가지 속내다." content:nil buttonTitlesArray:@[@"확인", @"취소"] type:ALERT_TYPE_LARGE];
    alert1.delegate = self;
    
    alert2 = [[CPAlert alloc] initWithTitle:nil contentText:@"지난 2월 12일 시작된 SK의 대만 퓨처스팀(2군) 전지훈련에 재활조로 참가한 두 선수는 더할 나위 없는 따뜻한 날씨 속에 순조롭게 재활 프로그램을 진행하고 있다. 김경기 SK 퓨처스팀 감독은 “재활조 선수들이 무난하게 페이스를 끌어올리고 있다”라며 반색했다. 2014년 SK의 1차 지명자인 이건욱은 입단 직후 팔꿈치인대접합수술(토미존 서저리)을 받았다." content:nil buttonTitlesArray:@[@"OK", @"Cancel"] type:ALERT_TYPE_DEFAULT];
    alert2.delegate = self;
    
    alert3 = [[CPAlert alloc] initWithTitle:@"한화 캠프 추가훈련, 후끈 달아오른 불펜" contentText:@"메인 그라운드는 텅 비어있었다. 외야 저편에 있는 불펜에서만 메아리처럼 소리가 울려퍼졌다. 투수들의 기합소리와 포수 미트에 꽂히는 굉음으로 불펜은 후끈 달아올라 있었다." content:nil buttonTitlesArray:@[@"OK"] type:ALERT_TYPE_DEFAULT];
    alert3.delegate = self;
    
    alert4 = [[CPAlert alloc] initWithTitle:@"한화 캠프" contentText:@"메인 그라운드는 텅 비어있었다. 외야 저편에 있는 불펜에서만 메아리처럼 소리가 울려퍼졌다. 투수들의 기합소리와 포수 미트에 꽂히는 굉음으로 불펜은 후끈 달아올라 있었다." content:nil buttonTitlesArray:@[@"확인",@"다음에",@"취소"] type:ALERT_TYPE_DEFAULT];
    alert4.delegate = self;
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 800)];
    UIView* testView = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];
    [testView setBackgroundColor:[UIColor brownColor]];
    alert5 = [[CPAlert alloc] initWithTitle:@"한화 캠프" contentText:nil content:testView buttonTitlesArray:@[@"확인",@"다음에",@"취소"] type:ALERT_TYPE_DEFAULT];
    alert5.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showAlert1:(id)sender {
    [alert1 show];
}

- (IBAction)showAlert2:(id)sender {
    [alert2 show];
}

- (IBAction)showAlert3:(id)sender {
    [alert3 show];
}
- (IBAction)showAlert4:(id)sender {
    [alert4 show];
}
- (IBAction)showAlert5:(id)sender {
    [alert5 show];
}

#pragma Alert Delegate
- (void)alert:(CPAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alert == alert1) {
        [eventTestTextField setText:[NSString stringWithFormat:@"showAlert1 - ButtonIndex : %ld",buttonIndex]];
    }else if(alert == alert2){
        [eventTestTextField setText:[NSString stringWithFormat:@"showAlert2 - ButtonIndex : %ld",buttonIndex]];        
    }else if(alert == alert3){
        [eventTestTextField setText:[NSString stringWithFormat:@"showAlert3 - ButtonIndex : %ld",buttonIndex]];
    }else if(alert == alert4){
        [eventTestTextField setText:[NSString stringWithFormat:@"showAlert4 - ButtonIndex : %ld",buttonIndex]];
    }
    NSLog(@"Selected Alert Button Index : %ld", buttonIndex);
}

@end
