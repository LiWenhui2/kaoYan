@Builder
export function FocusBuilder() {
  Focus()
}

interface FocusType {
  name: string
  major: string
  avatar: ResourceStr
}

@ComponentV2
struct Focus {
  pathStack: NavPathStack = new NavPathStack()
  focusData: FocusType[] = [
    { name: '露娜', major: '电子信息类', avatar: $r('app.media.focus_avatar1') },
    { name: '韩信', major: '计算机类', avatar: $r('app.media.focus_avatar2') },
    { name: '李白', major: '通信工程类', avatar: $r('app.media.focus_avatar3') },
    { name: '朵莉亚', major: '电子信息类', avatar: $r('app.media.focus_avatar4') }
  ]

  build() {
    NavDestination() {
      Column({ space: 30 }) {
        Text('跳过')
          .width('100%')
          .textAlign(TextAlign.End)
          .fontColor('#101010')
          .onClick(() => {
            this.pathStack.replacePathByName('Focus', null)
          })
        Text('推荐关注')
          .fontSize(26)
          .fontWeight(500)
          .fontColor('#101010')
          .margin({ bottom: 15 })
        Column({ space: 20 }) {
          Row({ space: 10 }) {
            Text('推荐关注的学长学姐')
              .fontColor('#cbcbcb')
              .fontSize(14)
            Text('换一批')
              .fontColor('#ccbe97')
              .fontSize(14)
          }
          .width('100%')
        }
      }
      .height('100%')
      .width('100%')
      .padding({ left: 15, right: 15, top: 30 })
    }
    .hideBackButton(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}