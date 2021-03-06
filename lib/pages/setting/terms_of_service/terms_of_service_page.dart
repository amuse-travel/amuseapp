import 'package:flutter/material.dart';

import '../../../main.dart';

class TermsOfServicePage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이용 약관 및 개인정보취급정책',
          style: TextStyle(
            fontSize: 16,
            fontWeight: MEDIUM,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverPersistentHeaderDelegate(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  '국내 여행 약관',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: MEDIUM,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _titleText(text: '제1조 (목적)'),
                _subTitleText(text: '이 약관은 ㈜어뮤즈(이하 "당사"라 함)과 여행자가 체결한 국내여행계약의 세부이행 및 준수사항을 정함을 목적으로 합니다.'),
                _titleText(text: '제2조 (여행의 종류 및 정의)'),
                _subTitleText(
                  text:
                      '여행의 종류와 정의는 다음과 같습니다.\n1. 일반모집여행 : 여행사가 수립한 여행조건에 따라 여행자를 모집하여 실시하는 여행.\n2. 희망여행 : 여행자가 희망하는 여행조건에 따라 여행사가 실시하는 여행.\n2. 위탁모집여행 : 여행사가 만든 모집여행상품의 여행자 모집을 타 여행업체에 위탁하여 실시하는 여행.',
                ),
                _titleText(text: '제3조 (여행사와 여행자 의무)'),
                _subTitleText(
                  text: '① "당사"는 여행자에게 안전하고 만족스러운 여행서비스를 제공하기 위하여 여행알선 및 안내․운송․숙박 등 여행계획의 수립 및 실행과정에서 맡은 바 임무를 충실히 수행하여야 합니다.\n② 여행자는 안전하고 즐거운 여행을 위하여 여행자간 화합도모 및 "당사"의 여행질서 유지에 적극 협조하여야 합니다.',
                ),
                _titleText(text: '제4조 (계약의 구성)'),
                _subTitleText(
                  text:
                      '① 여행계약은 여행계약서(붙임)와 여행약관․여행일정표(또는 여행 설명서)를 계약내용으로 합니다.\n② 여행계약서에는 "당사"의 상호, 소재지 및 관광진흥법 제9조에 따른 보증보험 등의 가입(또는 영업보증금의 예치 현황) 내용이 포함되어야 합니다.\n③ 여행일정표(또는 여행설명서)에는 여행일자별 여행지와 관광내용․교통수단․쇼핑횟수․숙박장소․식사 등 여행실시일정 및 ‘당사’ 제공 서비스 내용과 여행자 유의사항이 포함되어야 합니다.',
                ),
                _titleText(text: '제5조(계약체결 거절)'),
                _subTitleText(
                  text:
                      '"당사"는 여행자에게 다음 각 호의 1에 해당하는 사유가 있을 경우에는 여행자와의 계약체결을 거절할 수 있습니다.\n1. 질병, 신체이상 등의 사유로 개별관리가 필요하거나, 단체여행(다른 여행자의 여행에 지장을 초래하는 등)의 원활한 실시에 지장이 있다고 인정되는 경우\n2. 계약서에 명시한 최대행사인원이 초과된 경우',
                ),
                _titleText(text: '제6조 (특약)'),
                _subTitleText(text: '"당사"와 여행자는 관련법규에 위반되지 않는 범위 내에서 서면(전자문서를 포함한다. 이하 같다)으로 특약을 맺을 수 있습니다. 이 경우 "당사"는 특약의 내용이 표준약관과 다르고 표준약관보다 우선 적용됨을 여행자에게 설명하고 별도의 확인을 받아야 합니다.'),
                _titleText(text: '제7조 (계약서 등 교부 및 안전정보 제공)'),
                _subTitleText(
                  text: '"당사"는 여행자와 여행계약을 체결한 경우 계약서와 여행약관, 여행일정표(또는 여행설명서)를 각 1부씩 여행자에게 교부하고, 여행목적지에 관한 안전정보를 제공하여야 합니다. 또한 여행 출발 전 해당 여행지에 대한 안전정보가 변경된 경우에도 변경된 안전정보를 제공하여야 합니다.',
                ),
                _titleText(text: '제8조 (계약서 및 약관 등 교부 간주)'),
                _subTitleText(
                  text:
                      '다음 각 호의 경우에는 "당사"가 여행자에게 여행계약서와 여행약관 및 여행일정표(또는 여행설명서)가 교부된 것으로 간주합니다.\n1. 여행자가 인터넷 등 전자정보망으로 제공된 여행계약서, 약관 및 여행일정표(또는 여행설명서)의 내용에 동의하고 여행계약의 체결을 신청한 데 대해 "당사"가 전자정보망 내지 기계적 장치 등을 이용하여 여행자에게 승낙의 의사를 통지한 경우\n2. "당사"가 팩시밀리 등 기계적 장치를 이용하여 제공한 여행계약서, 약관 및 여행일정표(또는 여행설명서)의 내용에 대하여 여행자가 동의하고 여행계약의 체결을 신청하는 서면을 송부한 데 대해 "당사"가 전자정보망 내지 기계적 장치 등을 이용하여 여행자에게 승낙의 의사를 통지한 경우',
                ),
                _titleText(text: '제9조 (여행요금)'),
                _subTitleText(
                  text:
                      '① 여행계약서의 여행요금에는 다음 각 호가 포함됩니다. 다만, 희망여행은 당사자간 합의에 따릅니다.\n1. 항공기, 선박, 철도 등 이용운송기관의 운임(보통운임기준)\n2. 공항, 역, 부두와 호텔사이 등 송영버스요금\n3. 숙박요금 및 식사요금\n4. 안내자경비\n5. 여행 중 필요한 각종 세금\n6. 국내 공항․항만 이용료\n7. 일정표내 관광지 입장료\n8. 기타 개별계약에 따른 비용\n② 여행자는 계약 체결시 계약금(여행요금 중 10%이하의 금액)을 "당사"에게 지급하여야 하며, 계약금은 여행요금 또는 손해배상액의 전부 또는 일부로 취급합니다.\n③ 여행자는 제1항의 여행요금 중 계약금을 제외한 잔금을 여행출발 전일까지 "당사"에게 지급하여야 합니다.\n④ 여행자는 제1항의 여행요금을 당사자가 약정한 바에 따라 카드, 계좌이체 또는 무통장입금 등의 방법으로 지급하여야 합니다.\n⑤ 희망여행요금에 여행자 보험료가 포함되는 경우 "당사"는 보험회사명, 보상내용 등을 여행자에게 설명하여야 합니다.',
                ),
                _titleText(text: '제10조 (여행조건의 변경요건 및 요금 등의 정산)'),
                _subTitleText(
                  text:
                      '① 계약서 등에 명시된 여행조건은 다음 각 호의 1의 경우에 한하여 변경될 수 있습니다.\n1. 여행자의 안전과 보호를 위하여 여행자의 요청 또는 현지사정에 의하여 부득이하다고 쌍방이 합의한 경우\n2. 천재지변, 전란, 정부의 명령, 운송‧숙박기관 등의 파업‧휴업 등으로 여행의 목적을 달성할 수 없는 경우\n② "당사"가 계약서 등에 명시된 여행일정을 변경하는 경우에는 해당 날짜의 일정이 시작되기 전에 여행자의 서면 동의를 받아야 합니다. 이때 서면동의서에는 변경일시, 변경내용, 변경으로 발생하는 비용이 포함되어야 합니다.\n③ 천재지변, 사고, 납치 등 긴급한 사유가 발생하여 여행자로부터 여행일정 변경 동의를 받기 어렵다고 인정되는 경우에는 제2항에 따른 일정변경 동의서를 받지 아니할 수 있습니다. 다만, "당사"는 사후에 서면으로 그 변경 사유 및 비용 등을 설명하여야 합니다.\n④ 제1항의 여행조건 변경으로 인하여 제9조제1항의 여행요금에 증감이 생기는 경우에는 여행출발 전 변경 분은 여행출발 이전에, 여행 중 변경 분은 여행종료 후 10일 이내에 각각 정산(환급)하여야 합니다.\n⑤ 제1항의 규정에 의하지 아니하고 여행조건이 변경되거나 제13조 내지 제15조의 규정에 의한 계약의 해제․해지로 인하여 손해배상액이 발생한 경우에는 여행출발 전 발생 분은 여행출발이전에, 여행 중 발생 분은 여행종료 후 10일 이내에 각각 정산(환급)하여야 합니다.\n⑥ 여행자는 여행출발 후 자기의 사정으로 숙박, 식사, 관광 등 여행요금에 포함된 서비스를 제공받지 못한 경우 "당사"에게 그에 상응하는 요금의 환급을 청구할 수 없습니다. 다만, 여행이 중도에 종료된 경우에는 제15조에 준하여 처리합니다.',
                ),
                _titleText(
                  text: '제11조 (여행자 지위의 양도)',
                ),
                _subTitleText(
                  text:
                      '① 여행자가 개인사정 등으로 여행자의 지위를 양도하기 위해서는 "당사"의 승낙을 받아야 합니다. 이때 "당사"는 여행자 또는 여행자의 지위를 양도받으려는 자가 양도로 발생하는 비용을 지급할 것을 조건으로 양도를 승낙할 수 있습니다.\n② 전항의 양도로 발생하는 비용이 있을 경우 "당사"는 기한을 정하여 그 비용의 지급을 청구하여야 합니다.\n③ "당사"는 계약조건 또는 양도하기 어려운 불가피한 사정 등을 이유로 제1항의 양도를 승낙하지 않을 수 있습니다.\n④ 제1항의 양도는 "당사"가 승낙한 때 효력이 발생합니다. 다만, "당사"가 양도로 인해 발생한 비용의 지급을 조건으로 승낙한 경우에는 정해진 기한 내에 비용이 지급되는 즉시 효력이 발생합니다.\n⑤ 여행자의 지위가 양도되면, 여행계약과 관련한 여행자의 모든 권리 및 의무도 그 지위를 양도 받는 자에게 승계됩니다.',
                ),
                _titleText(text: '제12조 ("당사"의 책임)'),
                _subTitleText(
                  text:
                      '① 여행자는 여행에 하자가 있는 경우에 "당사"에게 하자의 시정 또는 대금의 감액을 청구할 수 있습니다. 다만, 그 시정에 지나치게 많은 비용이 들거나 그 밖에 시정을 합리적으로 기대할 수 없는 경우에는 시정을 청구할 수 없습니다.\n② 여행자는 시정 청구, 감액 청구를 갈음하여 손해배상을 청구하거나 시정 청구, 감액 청구와 함께 손해배상을 청구 할 수 있습니다.\n③ 제1항 및 제2항의 권리는 여행기간 중에도 행사할 수 있으며, 여행종료일부터 6개월 내에 행사하여야 합니다.\n④ "당사"는 여행 출발시부터 도착시까지 "당사" 본인 또는 그 고용인, 현지 "당사" 또는 그 고용인 등(이하 ‘사용인’이라 함)이 제3조제1항에서 규정한 "당사" 임무와 관련하여 여행자에게 고의 또는 과실로 손해를 가한 경우 책임을 집니다.\n⑤ "당사"는 항공기, 기차, 선박 등 교통기관의 연발착 또는 교통체증 등으로 인하여 여행자가 입은 손해를 배상하여야 합니다. 다만, "당사"가 고의 또는 과실이 없음을 입증한 때에는 그러하지 아니합니다.\n⑥ "당사"는 자기나 그 사용인이 여행자의 수하물 수령․인도․보관 등에 관하여 주의를 해태하지 아니하였음을 증명하지 아니 하는 한 여행자의 수하물 멸실, 훼손 또는 연착으로 인하여 발생한 손해를 배상하여야 합니다.',
                ),
                _titleText(text: '제13조 (여행출발 전 계약해제)'),
                _subTitleText(
                  text:
                      '① "당사" 또는 여행자는 여행출발전 이 여행계약을 해제할 수 있습니다. 이 경우 발생하는 손해액은 "소비자분쟁해결기준"(공정거래위원회 고시)에 따라 배상합니다.\n② "당사" 또는 여행자는 여행출발 전에 다음 각 호의 1에 해당하는 사유가 있는 경우 상대방에게 제1항의 손해배상액을 지급하지 아니하고 이 여행계약을 해제할 수 있습니다.\n"당사"가 해제할 수 있는 경우\n제10조 제1항 제1호 및 제2호 사유의 경우\n여행자가 다른 여행자에게 폐를 끼치거나 여행의 원활한 실시에 현저한 지장이 있다고 인정될 때\n질병 등 여행자의 신체에 이상이 발생하여 여행에의 참가가 불가능한 경우\n여행자가 계약서에 기재된 기일까지 여행요금을 지급하지 아니하는 경우\n여행자가 해제할 수 있는 경우\n가. 제10조 제1항 제1호 및 제2호 사유의 경우\n나. "당사"가 제18조에 따른 공제 또는 보증보험에 가입하지 아니 하였거나 영업보증금을 예치하지 않은 경우\n다. 여행자의 3촌이내 친족이 사망한 경우\n라. 질병 등 여행자의 신체에 이상이 발생하여 여행에의 참가가 불가능한 경우\n마. 배우자 또는 직계존비속이 신체이상으로 3일 이상 병원(의원)에 입원하여 여행 출발시까지 퇴원이 곤란한 경우 그 배우자 또는 보호자 1인\n바. "당사"의 귀책사유로 계약서에 기재된 여행일정대로의 여행실시가 불가능해진 경우',
                ),
                _titleText(text: '제14조 (최저행사인원 미 충족시 계약해제)'),
                _subTitleText(
                  text:
                      '① "당사"는 최저행사인원이 충족되지 아니하여 여행계약을 해제하는 경우 당일여행의 경우 여행출발 24시간 이전까지, 1박2일 이상인 경우에는 여행출발 48시간 이전까지 여행자에게 통지하여야 합니다.\n② "당사"가 여행참가자 수의 미달로 전항의 기일내 통지를 하지 아니하고 계약을 해제하는 경우 이미 지급받은 계약금 환급 외에 계약금 100% 상당액을 여행자에게 배상하여야 합니다.',
                ),
                _titleText(text: '제15조 (여행출발 후 계약해지)'),
                _subTitleText(
                  text:
                      '① "당사" 또는 여행자는 여행출발 후 부득이한 사유가 있는 경우 각 당사자는 여행계약을 해지할 수 있습니다. 다만, 그 사유가 당사자 한쪽의 과실로 인하여 생긴 경우에는 상대방에게 손해를 배상하여야 합니다.\n② 제1항에 따라 여행계약이 해지된 경우 귀환운송 의무가 있는 "당사"는 여행자를 귀환운송 할 의무가 있습니다.\n③ 제1항의 계약해지로 인하여 발생하는 추가 비용은 그 해지사유가 어느 당사자의 사정에 속하는 경우에는 그 당사자가 부담하고, 양 당사자 누구의 사정에도 속하지 아니하는 경우에는 각 당사자가 추가 비용의 50%씩을 부담합니다.\n④ 여행자는 여행에 중대한 하자가 있는 경우에 그 시정이 이루어지지 아니하거나 계약의 내용에 따른 이행을 기대할 수 없는 경우에는 계약을 해지할 수 있습니다.\n⑤ 제4항에 따라 계약이 해지된 경우 "당사"는 대금청구권을 상실합니다. 다만, 여행자가 실행된 여행으로 이익을 얻은 경우에는 그 이익을 "당사"에게 상환하여야 합니다.\n⑥ 제4항에 따라 계약이 해지된 경우 "당사"는 계약의 해지로 인하여 필요하게 된 조치를 할 의무를 지며, 계약상 귀환운송 의무가 있으면 여행자를 귀환운송하여야 합니다. 이 경우 귀환운송비용은 원칙적으로 "당사"가 부담하여야 하나, 상당한 이유가 있는 때에는 "당사"는 여행자에게 그 비용의 일부를 청구할 수 있습니다.',
                ),
                _titleText(text: '제16조 (여행의 시작과 종료)'),
                _subTitleText(text: '여행의 시작은 출발하는 시점부터 시작하며 여행일정이 종료하여 최종목적지에 도착함과 동시에 종료합니다. 다만, 계약 및 일정을 변경할 때에는 예외로 합니다.'),
                _titleText(text: '제17조 (설명의무)'),
                _subTitleText(text: '"당사"는 이 계약서에 정하여져 있는 중요한 내용 및 그 변경사항을 여행자가 이해할 수 있도록 설명하여야 합니다.'),
                _titleText(text: '제18조 (보험가입 등)'),
                _subTitleText(text: '"당사"는 여행과 관련하여 여행자에게 손해가 발생 한 경우 여행자에게 보험금을 지급하기 위한 보험 또는 공제에 가입하거나 영업 보증금을 예치하여야 합니다.'),
                _titleText(text: '제19조 (기타사항)'),
                _subTitleText(
                  text: '① 이 계약에 명시되지 아니한 사항 또는 이 계약의 해석에 관하여 다툼이 있는 경우에는 "당사"와 여행자가 합의하여 결정하되, 합의가 이루어지지 아니한 경우에는 관계법령 및 일반관례에 따릅니다.\n② 특수지역에의 여행으로서 정당한 사유가 있는 경우에는 이 표준약관의 내용과 다르게 정할 수 있습니다.',
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverPersistentHeaderDelegate(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  '개인정보취급정책',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: MEDIUM,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
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
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverPersistentHeaderDelegate({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
