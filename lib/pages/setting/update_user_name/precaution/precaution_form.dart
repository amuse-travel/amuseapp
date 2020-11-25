import 'package:amusetravel/blocs/chat/chat_bloc.dart';
import 'package:amusetravel/cubits/update_profile/update_profile_cubit.dart';
import 'package:amusetravel/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';

class PrecautionForm extends StatefulWidget {
  const PrecautionForm({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;

  @override
  _PrecautionFormState createState() => _PrecautionFormState();
}

class _PrecautionFormState extends State<PrecautionForm> {
  String _userName;

  @override
  void initState() {
    super.initState();

    _userName = widget.userName;
  }

  void _onUpdateUserName() {
    context.read<UpdateProfileCubit>().updateUserName(userName: _userName);
  }

  Widget _titleText({String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: BOLD,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _subTitleText({String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: REGULAR,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (BuildContext buildContext, UpdateProfileState state) {
        if (state is UpdateProfileUserName) {
          CustomToast(message: '닉네임 설정 완료').show();
          context.read<ChatBloc>().add(ChatReadyToIncomingMessage());
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
        if (state is UpdateProfileFailure) {
          CustomToast(message: '실패').show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '개인정보 처리방침 및 이용약관',
            style: TextStyle(
              fontSize: 16,
              fontWeight: MEDIUM,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _subTitleText(
                        text:
                            '㈜어뮤즈트래블(이하 ‘회사’)는 고객의 개인정보보호와 정보주체자의 권익보장을 위해 최선의 노력을 다하고 있습니다. 회사는 『개인정보보호법』 관련 조항과 『정보통신망 이용촉진 및 정보보호에 관한 법률』의 기준에 따라 ‘개인정보처리방침’을 수립하여 이를 준수하고 있습니다. 고객의 개인정보가 어떠한 목적과 절차로 수집,이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 다음과 같이 알려드립니다. 본 개인정보처리방침을 개정하는 경우에는 회사 웹사이트를 통하여 사전에 고지 하겠습니다.',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _titleText(text: '1. 개인정보 수집 및 이용목적'),
                      _subTitleText(
                        text:
                            '(1) 회사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 고객으로부터 최소한의 필수정보를 수집하며, 제공한 모든 개인정보는 별도의 동의가 없는 한 해당목적 이외의 다른 목적으로 사용하지 않습니다.\n(2) 회사는 개인정보의 수집항목, 이용목적, 용도 등이 변경될 경우 사전 고지하며, 고객의 동의를 구할 것입니다.\n(3) 회사는 수집한 개인정보를 다음의 목적을 위하여 사용합니다.\n서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 : 여행상품 예약, 여행자보험 가입, 항공권/호텔 등의 예약 및 출입국 정보확인, 예약내역의 확인 및 상담, 국내 해외 여행서비스 이행, 컨텐츠 제공, 여행서비스 이용 시 회원의 우대, 내부방침 상 반복된 악성민원 제기로 인한 이용자 본인확인 및 서비스 제한, 마일리지 적립 / 조회 / 사용 및 이에 관한 안내, 회원카드 발급, 구매 및 요금결제, 물품배송 또는 청구서 등 발송, 본인인증 및 금융서비스 등\n회원관리 : 회원제 서비스 이용을 위한 본인확인, 개인식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 이용 및 이용횟수 제한, 연령확인, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 분쟁조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달 등',
                      ),
                      _titleText(text: '2. 개인정보 수집 및 이용목적'),
                      _subTitleText(
                        text:
                            '(1) 회사는 적법한 절차와 법적 기준에 의거하여 고객의 개인정보를 수집하고 있으며, 고객의 서비스이용에 필요한 최소한의 정보만을 수집하고 있습니다. 정보통신망법과 개인정보보호법에 의거하여 수집, 이용을 제한하고 있습니다.\n(2) 회사는 고객의 인권을 침해할 우려가 있는 민감한 개인정보항목(성향, 성생활정보 등)은 수집하지 않습니다. 그러나, 당사의 중요서비스인 여행서비스 진행을 위해 의학적 도움이 필요한 고객의 경우, 또는 고객이 자발적으로 제공한 경우에 한하여 아래의 정보를 수집하고 있습니다.\n수집 항목 : 건강상황(일정 중 발생되는 질병/상해 정보 포함), 섭취불가/비선호 음식(알러지 등) 정보\n(3) 회사에서 운영하는 홈페이지 ( https://amusetravel.com) 에 회원가입, 모바일 어플리케이션, 회사 상품을 판매하는 대리점에서 고객가입신청서 작성, 마일리지클럽 가입신청서 작성, 여행상품예약, 홈페이지 또는 전국 대리점에서 경품 행사 응모, 상담게시판, 전화, 팩스를 통한 본인 확인, 제휴사로부터의 제공 등으로 개인정보를 수집합니다.',
                      ),
                      _titleText(text: '3. 개인정보의 이용 및 보유기간'),
                      _subTitleText(
                        text:
                            '(1) 개인정보 이용기간\n고객님의 개인정보는 서비스를 제공하는 기간 또는 분쟁처리 기간 동안에 한하여 보유하며 정보주체의 삭제 요구와 가입 탈퇴 동의가 있을 경우 지체없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우는 아래와 같이 관계법령에서 정한 일정기간 동안 회원 정보를 안전하게 보관합니다.\n계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래 등에서의 소비자보호에 관한 법률)\n대금결재 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래 등에서의 소비자보호에 관한 법률)\n소비자의 불만 또는 분쟁처리에 관한 기록 : 3년(전자상거래 등에서의 소비자보호에 관한 법률)\n(2) 개인정보 유효기간 제도 준행\n회사는 개인정보 유효기간제도를 준행하며, 해당 정보통신 서비스를 지정한 유효기간 동안 이용하지 않은 이용자의 개인정보를 보호하기 위하여 파기 등의 필요한 조치를 취하여 개인정보의 오, 남용 및 유출을 방지하고 있습니다.\n회사는 회원가입시 지정한 유효기간 만료가 도래하기 30일 전까지, 회사의 보안규정 및 지침에 따라 이용자의 개인정보항목이 파기 되거나 보관이 필요 할 경우 관련 법령에 따라 안전하게 분리 저장, 관리되는 사실을 고지합니다.',
                      ),
                      _titleText(text: '4. 개인정보 제3자 제공에 관한 사항'),
                      _subTitleText(text: '회사는 회원고객의 동의가 있거나 관련 법령의 규정에 의한 경우를 제외하고 어떠한 경우에도 ‘개인정보의 수집 및 이용목적’ 에서 고지한 범위를 넘어서거나, 해당되는 회원 서비스 영역과 무관한 타 기업/기관에 제공하거나 이용하지 않습니다.'),
                      _titleText(text: '5. 어뮤즈트래블에서 고객의 개인정보를 위탁하는 업무 내용 및 현황'),
                      _subTitleText(
                        text:
                            '(1) 회사는 고객편의 서비스를 원활하게 제공하기 위해서 일부 업무를 전문업체에 위탁 운영하고 있습니다.\n(2) 회사는 개인정보 보호의 만전을 기하기 위하여 서비스 제공자의 개인정보 처리위탁관련 적법한 처리절차, 보안지시엄수, 개인정보에 관한 비밀 유지, 업무 목적 및 범위를 벗어난 사용의 제한, 재위탁 제한 등 사고시의 손해배상 책임부담을 명확히 규정하고 해당 계약내용을 서면 또는 전자적으로 보관하여 이를 엄격하게 관리감독 하고 있습니다.\n(3) 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개합니다',
                      ),
                      _titleText(text: '6. 개인정보의 자동 수집 장치에 관한 사항'),
                      _subTitleText(text: '회사는 이용자의 개인화된 서비스를 제공하기 위해 "소셜로그인"을 통해 이용자의 이메일을 제공받습니다. 회사는 이러한 이메일 정보를 통해 이용자께 편리한 맞춤 서비스를 제공하게 됩니다. 이용자의 개인정보(이메일정보)는 회원탈퇴를 통해 즉시 파기 가능합니다.'),
                      _titleText(text: '7. 개인정보 주체의 권리와 의무'),
                      _subTitleText(
                        text:
                            '개인정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보보호 관련 권리를 행사할 수 있습니다.\n1. 개인정보 열람요구 (정보주체 및 정보주체 이외로 부터 수집된 개인정보의 출처, 처리목적, 이용내역에 대한 열람)\n2. 오류 등이 있을 때 정정요구\n3. 개인정보 삭제요구\n4. 처리정지 요구\n상기 항목에 대한 권리행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, 회사는 이에 대해 지체없이 조치하겠습니다. 정보주체자는 개인정보보호법 등 관계법령을 위반하는 수준으로, 회사가 처리하고 있는 정보주체 본인 및 타인의 개인정보 및 사생활을 침해하지 않도록 해야 할 의무가 있습니다.',
                      ),
                      _titleText(text: '8. 개인정보의 열람 및 정정,삭제방법'),
                      _subTitleText(
                        text: '이용자의 개인정보(이메일주소)는 회사 관리자 외에 아무도 열람할 수 없으며, 앱 내에 회원탈퇴 과정을 통해 언제든지 개인정보의 수집 및 이용 동의를 철회가 가능합니다. 기타 문의사항 혹은 오류발생 시 어뮤즈트래블 02-719-6811 로 문의해주시면 신속하게 처리해 드립니다.',
                      ),
                      _titleText(
                        text: '9. 만14세 미만 아동의 개인정보 보호',
                      ),
                      _subTitleText(
                        text:
                            '만 14세 미만 아동의 경우, 법정대리인(부모, 법정대리인, 친권자)을 통하여 여행상품/서비스 이용계약이 가능하며, 해당 서비스 수행에 필요한 최소한의 개인정보를 수집합니다. 만14세 미만 아동의 법정대리인은 아동의 개인정보 열람, 정정을 요구하시거나, 개인정보의 수집과 이용,제공, 위탁에 대한 동의철회를 하실 수 있습니다. 만 14세 미만 아동의 개인정보는 법정대리인의 동의 없이는 제3자에게 제공하거나 공유되지 않습니다.',
                      ),
                      _titleText(
                        text: '10. 개인정보 파기관리',
                      ),
                      _subTitleText(
                        text:
                            '회사는 수집한 개인정보의 이용목적이 달성된 후에는 이용 및 보관기간에 따라 해당 정보를 지체 없이 파기하며 파기절차 및 방법은 다음과 같습니다.\n가. 파기절차\n고객님이 회원가입 및 여행서비스 이용 등을 위해 기재한 개인정보는 이용목적이 달성된 후 내부방침 및 기타 관련 법령에 의한 정보보호사유에 따라(이용 및 보유기간 참조) 일정기간 동안 저장된 후 삭제되거나 파기합니다.\n나. 파기방법종이에 출력된 개인정보: 분쇄기를 이용하여 분쇄\n전자적파일형태로 저장된 개인정보: 개인정보는 남기지 않으며, 기록을 재생할수 없는 방법을 통하여 기록삭제\n다. 파기시점\n회원가입정보의 경우 : 회원가입을 탈퇴하거나 회원에서 제명된 때.\n대금지급정보의 경우 : 대금의 완제일 또는 채권소멸 시효기간이 만료된 때\n설문조사,이벤트 등의 목적을 위하여 수집한 경우 : 당해 설문조사,이벤트 등이 종료한 때\n다만, 수집목적 또는 제공받은 목적이 달성된 경우에도 상법 등 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 회원의 개인정보를 보유할 수 있습니다.',
                      ),
                      _titleText(text: '11. 개인정보관련 의견수렴'),
                      _subTitleText(
                        text:
                            '개인정보보호 관련 정책 문의 및 고객님의 기타 의견이 있을 경우 전자메일 및 팩스 수신처는 다음과 같습니다.\n전자우편 : info@amusetravel.com\n전화번호 : 02-719-6811\n팩스번호 : 02-719-6820\n주소 : 서울특별시 마포구 백범로 31길 서울창업허브 본관 8층 807호\n개인정보 침해 및 신고 상담이 필요하신 경우에는 아래의 외부 기관에 문의를 통해서 확인 받으실 수 있습니다.\n개인정보 분쟁 조정 위원회\n전화 : (국번없이) 118\nURL : https://kopico.go.kr\n개인정보 침해신고 센터\n전화 : (국번없이) 118\nURL : http://privacy.kisa.or.kr\n대검찰청 사이버범죄수사단\n전화 : 02-3480-3571\n이메일 : cybercid@spo.go.kr\n경찰청 사이버안전국\n전화 : (국번없이) 182\nURL : http://cyberbureau.police.go.kr',
                      ),
                      _titleText(text: '12. 개인정보처리방침 변경 등에 대한 고지'),
                      _subTitleText(
                        text:
                            '개인정보처리방침내용의 추가, 삭제 및 수정이 있을 시에는 개정내용이 반영되기 전에 웹 사이트의 공지사항을 통하여 고지할 것입니다. 또한 개인정보 처리방침에 버전번호 및 개정일자 등을 부여하여 개정여부를 쉽게 알 수 있도록 하며, 중요한 사항일 경우, 고객의 이메일로 안내사항을 전달해 드리도록 하겠습니다. \n개인정보처리방침 시행일자 2020년 01월 28일',
                      ),
                      _titleText(text: '13. 개인정보 관리책임자 및 담당자 연락처'),
                      _subTitleText(
                        text:
                            '회사는 고객의 개인정보를 안전하게 보호하고 개인정보와 관련된 불만 및 민원사항을 처리하기 위하여 개인정보 관리책임 조직을 지정하고 있습니다. 개인정보와 관련된 문의사항이 있으시면 아래의 담담자에게 연락주시기 바랍니다. 기준에 따라 성실하고 신속하게. 답변드리도록 하겠습니다.\n가. 개인정보 보호책임자\n이름 : 오진석\n직책 : 연구소장\n전화 : 02-719-6810\n이메일 : info@amusetravel.com',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: RaisedButton(
                  onPressed: _onUpdateUserName,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                  color: Theme.of(context).secondaryHeaderColor,
                  child: const Text(
                    '동의 및 시작하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
