@Builder
export function SendCodeBuilder() {
  SendCode()
}

@ComponentV2
struct SendCode {
  pathStack: NavPathStack = new NavPathStack()
  @Local code: string = ''
  @Local phoneNumber: string = ''
  @Local count: number = 60

  @Builder
  sendCode() {
    Row() {
      Text('验证码已发送')
        .fontColor('#fff')
        .fontSize(12)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .backgroundColor('#585858')
    .width(100)
    .height(80)
    .borderRadius(8)
  }

  aboutToAppear(): void {
    this.sendCodeDialog.open()
    setTimeout(() => {
      this.sendCodeDialog.close()
    }, 2000)
    const timeId: number = setInterval(() => {
      this.count--
      if (this.count == 0) {
        clearInterval(timeId)
      }
    }, 1000)
  }

  sendCodeDialog: CustomDialogController = new CustomDialogController({
    builder: this.sendCode,
    width: 100,
    height: 80,
    cornerRadius: 8,
    isModal: false
  })

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Row() {
          Image($r('app.media.back'))
            .width(18)
            .onClick(() => {
              this.pathStack.pop()
            })
        }
        .padding({ top: 15, bottom: 15 })
        .width('100%')

        Text('输入短信验证码')
          .fontColor('#101010')
          .fontWeight(500)
          .fontSize(26)
          .width('100%')
        Text(`已向您的手机 ${this.phoneNumber.slice(0, 3)}****${this.phoneNumber.slice(-4)} 发送验证码`)
          .fontColor('#cecece')
          .fontSize(14)
          .fontWeight(600)
          .width('100%')
          .margin({ bottom: 15 })
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          ForEach([0, 1, 2, 3], (i: number) => {
            Stack() {
              Column({ space: 5 }) {
                Text(this.code[i] || '')
                  .fontColor('#101010')
                  .fontWeight(600)
                  .fontSize(26)
                  .height(30)
                Divider()
                  .width(75)
                  .color('#eaeaea')
                  .strokeWidth(2)
              }

              TextInput()
                .type(InputType.Number)
                .maxLength(4)
                .padding({ left: 38, bottom: 10 })
                .fontSize(26)
                .fontColor(Color.Transparent)
                .fontWeight(600)
                .backgroundColor('rgba(0,0,0,0)')
                .borderRadius(0)
                .caretColor(Color.Transparent)
                .onChange(value => {
                  this.code = value
                })
            }
          })
        }

        Text(this.count == 0 ? '重新发送' : `重新发送（${this.count}s）`)
          .fontColor(this.count == 0 ? '#005bff' : '#cecece')
          .margin({ top: 20, bottom: 30 })
          .onClick(() => {
            if (this.count == 0) {
              this.count = 60
              const timeId: number = setInterval(() => {
                this.count--
                if (this.count == 0) {
                  clearInterval(timeId)
                }
              }, 1000)
            }
          })
        Button('下一步')
          .width(300)
          .height(45)
          .backgroundColor(this.code.length == 4 ? '#0a59f7' : '#f2f2f2')
          .fontColor('#cecece')
          .fontWeight(600)
          .stateEffect(false)
          .onClick(() => {
            if (this.code.length == 4) {
              this.pathStack.replacePathByName('BaseInfo', null)
            }
          })
      }
      .height('100%')
      .width('100%')
      .padding({ left: 15, right: 15 })
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
      this.phoneNumber = context.pathInfo.param as string
      console.log(this.phoneNumber)
    })
  }
}