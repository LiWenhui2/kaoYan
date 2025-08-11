@Builder
export function StartBuilder() {
  Start()
}

@ComponentV2
struct Start {
  aboutToAppear(): void {
    let timeId: number = setInterval(() => {
      this.count--
      if (this.count == 0) {
        clearInterval(timeId)
        this.pathStack.replacePathByName('Login',null)
      }
    }, 1000)

  }

  pathStack: NavPathStack = new NavPathStack()
  @Local count: number = 1

  build() {
    NavDestination() {
      Column() {
        Stack({ alignContent: Alignment.TopEnd }) {
          Row()
            .width('100%')
            .height(110)
            .backgroundColor('#e6e4e7')
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
          Text(`${this.count}s`)
            .width(68)
            .height(30)
            .backgroundColor('#f9f9f9')
            .fontSize(14)
            .fontColor('#cecece')
            .fontWeight(600)
            .borderRadius(15)
            .textAlign(TextAlign.Center)
            .margin({ top: 30, right: 15 })
            .onClick(()=>{
              this.pathStack.replacePathByName('Login',null)
            })
        }

        Image($r('app.media.start_bg'))
          .width('100%')
        Row({ space: 10 }) {
          Text('Design by vonphy')
            .fontColor('#101010')
            .fontWeight(500)
          Row() {
            Image($r('app.media.start_avatar'))
              .width(50)
          }
          .borderRadius('50%')
          .clip(true)
        }
        .padding({ top: 25, right: 15 })
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      .backgroundColor('#e6e4e7')
      .width('100%')
      .height('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}