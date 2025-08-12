@Builder
export function SendCodeBuilder() {
  SendCode()
}

@ComponentV2
struct SendCode {
  pathStack: NavPathStack = new NavPathStack()
  @Local code: string = '1234'

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Row() {
          Image($r('app.media.back'))
            .width(18)
        }
        .padding({ top: 15, bottom: 15 })
        .width('100%')

        Text('输入短信验证码')
          .fontColor('#101010')
          .fontWeight(500)
          .fontSize(26)
          .width('100%')
        Text('已向您的手机1234发送验证码')
          .fontColor('#cecece')
          .fontSize(14)
          .fontWeight(600)
          .width('100%')
          .margin({ bottom: 15 })
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          ForEach([1, 2, 3, 4], (i: number) => {
            Stack() {
              Column({ space: 5 }) {
                Text('1')
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
                .maxLength(1)// .padding({ left: 32, right: 32 })
                .fontSize(26)
                .fontColor('#101010')
                .fontWeight(600)
                .backgroundColor('rgba(0,0,0,0)')
                .borderRadius(0)
                .caretColor('#101010')
            }
          })
        }
      }
      .height('100%')
      .width('100%')
      .padding({ left: 15, right: 15 })
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}