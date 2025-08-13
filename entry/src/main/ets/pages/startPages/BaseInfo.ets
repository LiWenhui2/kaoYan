@Builder
export function BaseInfoBuilder() {
  BaseInfo()
}

@Extend(Text)
function titleStyle() {
  .fontWeight(600)
  .fontSize(14)
  .fontColor('#101010')
  .width('100%')
  .margin({ bottom: 15 })
}

@ComponentV2
struct BaseInfo {
  pathStack: NavPathStack = new NavPathStack()
  @Local isGenderSelect: boolean = true

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Text('跳过')
          .width('100%')
          .textAlign(TextAlign.End)
          .fontColor('#101010')
          .fontWeight(500)
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
            TextInput({ placeholder: '请填写昵称' })
              .placeholderColor('#cecece')
              .placeholderFont({ weight: 700 })
              .backgroundColor('#fff')
              .borderRadius(0)
              .padding(0)
              .caretColor('#cecece')
            Divider().color('#eaeaea').strokeWidth(1)
          }

          Column({ space: 5 }) {
            Text('考研年份')
              .titleStyle()
            Text('请选择考研时间')
              .fontColor('#cecece')
              .fontWeight(700)
              .backgroundColor('#fff')
              .width('100%')
              .onClick(() => {
                this.getUIContext().showTextPickerDialog({
                  range: [new Date().getFullYear().toString()]
                })
              })
            Divider().color('#eaeaea').strokeWidth(1)
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