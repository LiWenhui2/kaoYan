@Builder
export function BaseInfoBuilder() {
  BaseInfo()
}

@Extend(Text)
function titleStyle() {
  .fontWeight(500)
  .fontSize(14)
  .fontColor('#101010')
  .width('100%')
  .margin({ bottom: 15 })
}

@ComponentV2
struct BaseInfo {
  pathStack: NavPathStack = new NavPathStack()
  @Local isGenderSelect: boolean = true
  @Local nickName: string = ''
  @Local data: string = '请选择考研时间'
  @Local academyInfo: string = ''

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Text('跳过')
          .width('100%')
          .textAlign(TextAlign.End)
          .fontColor('#101010')
          .fontWeight(500)
          .onClick(() => {
            this.pathStack.replacePathByName('Focus', null)
          })
        Text('填写基本信息')
          .fontSize(26)
          .fontWeight(500)
          .fontColor('#101010')
        Text('向研友介绍一下自己吧')
          .fontColor('#cecece')
          .fontSize(14)
          .fontWeight(600)
        Row() {
          Image($r('app.media.baseInfo_avatar'))
            .width(40)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .height(70)
        .width(70)
        .borderRadius('50%')
        .backgroundColor('#f9f9f9')

        Text('上传头像')
          .fontColor('#cecece')
          .fontSize(14)
          .fontWeight(600)
          .margin({ bottom: 5 })
        Row({ space: 40 }) {
          Row({ space: 5 }) {
            Radio({
              group: 'gender',
              value: '男'
            })
              .onClick(() => {
                this.isGenderSelect = true
              })
              .width(15)
              .checked(true)
            Text('男生')
              .fontColor(this.isGenderSelect ? '#ccbe97' : '#cecece')
              .fontSize(14)
              .fontWeight(500)
          }

          Row({ space: 5 }) {
            Radio({
              group: 'gender',
              value: '女',
            })
              .onClick(() => {
                this.isGenderSelect = false
              })
              .width(15)
            Text('女生')
              .fontColor(this.isGenderSelect ? '#cecece' : '#ccbe97')
              .fontSize(14)
              .fontWeight(500)
          }
        }
        .margin({ bottom: 10 })

        Divider().color('#eaeaea').strokeWidth(1)
        Column({ space: 10 }) {
          Column({ space: 5 }) {
            Text('昵称')
              .titleStyle()
            TextInput({ placeholder: '请填写昵称', text: $$this.nickName })
              .placeholderColor('#cecece')
              .placeholderFont({ weight: 500 })
              .backgroundColor('#fff')
              .borderRadius(0)
              .padding(0)
              .caretColor('#cecece')
              .fontColor('#101010')
              .fontWeight(700)

            Divider().color('#eaeaea').strokeWidth(1)
          }

          Column({ space: 5 }) {
            Text('考研年份')
              .titleStyle()
            Text(this.data)
              .fontColor(this.data == '请选择考研时间' ? '#cecece' : '#101010')
              .fontWeight(500)
              .backgroundColor('#fff')
              .width('100%')
              .onClick(() => {
                const range: string[] = []
                for (let i = 0; i < 10; i++) {
                  const year: number =
                    new Date(`${new Date().getFullYear()}-12-21`) > new Date() ? new Date().getFullYear() :
                      new Date().getFullYear() + 1
                  range.push(year + i + '')
                }
                this.getUIContext().showTextPickerDialog({
                  range: range,
                  canLoop: false,
                  onAccept: (res => {
                    this.data = res.value as string
                  })
                })
              })
            Divider().color('#eaeaea').strokeWidth(1)
          }

          Column({ space: 5 }) {
            Text('报考院校')
              .titleStyle()
            TextInput({ placeholder: '请填写报考院校', text: $$this.academyInfo })
              .placeholderColor('#cecece')
              .placeholderFont({ weight: 500 })
              .backgroundColor('#fff')
              .borderRadius(0)
              .padding(0)
              .caretColor('#cecece')
              .fontColor('#101010')
              .fontWeight(700)

            Divider().color('#eaeaea').strokeWidth(1)
            Button('下一步')
              .width(300)
              .height(45)
              .backgroundColor(this.nickName && this.academyInfo && this.data != '请选择考研年份' ? '#0a59f7' :
                '#f2f2f2')
              .fontColor('#cecece')
              .fontWeight(600)
              .stateEffect(false)
              .margin({ top: 220 })
              .onClick(() => {
                if (this.nickName && this.academyInfo && this.data != '请选择考研年份') {
                  this.pathStack.replacePathByName('Focus', null)
                }
              })
          }
        }

      }
      .padding(15)
      .height('100%')
      .width('100%')
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}