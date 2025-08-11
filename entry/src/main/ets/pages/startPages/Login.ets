@Builder
export function LoginBuilder() {
  Login()
}

interface loginType {
  icon: ResourceStr
  bgc: ResourceColor
  text: string
}

@Extend(Text)
function textStyles() {
  .fontSize(14)
  .fontWeight(500)
  .fontColor('#101010')
}

@ComponentV2
struct Login {
  pathStack: NavPathStack = new NavPathStack()
  @Local loginType: loginType[] = [
    { icon: $r('app.media.start_login_wechat'), bgc: '#96e597', text: '微信登录' },
    { icon: $r('app.media.start_login_QQ'), bgc: '#8ed7ea', text: 'QQ登录' },
    { icon: $r('app.media.start_login_web'), bgc: '#ea8e8e', text: '微博登录' }
  ]
  @Local phoneNumber: string = ''
  @Local phoneNumberIsValidate: boolean = false

  @Builder
  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween }) {
        Column({ space: 30 }) {
          Text('跳过')
            .width('100%')
            .textAlign(TextAlign.End)
            .textStyles()
          Text('输入手机号')
            .fontSize(24)
            .fontWeight(500)
            .margin({ top: 5, bottom: 5 })
            .width('100%')
          Row({ space: 5 }) {
            Text('+86')
              .textStyles()
            Image($r('app.media.start_area_code'))
              .width(24)
            TextInput({ placeholder: '请输入您的手机号', text: $$this.phoneNumber })
              .backgroundColor('#fff')
              .placeholderColor('#cecece')
              .placeholderFont({ size: 14, weight: 600 })
              .padding(0)
              .layoutWeight(1)
            Image($r('app.media.start_clearInput'))
              .width(20)
              .onClick(() => {
                this.phoneNumber = ''
                console.log(this.phoneNumber + '111')
              })
          }
          .border({ width: { bottom: 1 }, color: '#f2f2f2' })
          .padding({ left: 10, right: 10, bottom: 8 })
          .width('100%')

          Button('下一步')
            .width(300)
            .height(45)
            .backgroundColor('#f2f2f2')
            .fontColor('#cecece')
            .fontWeight(600)
          Text('账户密码登录')
            .textStyles()
            .fontSize(13)
            .width('100%')
        }
        .padding({ top: 25, right: 15, left: 15 })

        Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
          ForEach(this.loginType, (item: loginType) => {
            Column({ space: 10 }) {
              Row() {
                Image(item.icon)
                  .width(24)
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(item.bgc)
              .width(55)
              .height(55)
              .borderRadius('50%')

              Text(item.text)
                .textStyles()
            }
          })
        }
        .padding({ bottom: 100, left: 10, right: 10 })
      }
      .width('100%')
      .height('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}