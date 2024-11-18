import SwiftUI

struct dataModel:Identifiable{
    var id = UUID()
    var name:String
    var position:CGPoint
}

struct CollageByMyselfView: View {

    @State var DraggingNearTheTrash = false
    //휴지통 버튼에 근접했는지 알려주는 요소

    @State var vmItem:[dataModel] = []
    //위에서 만든 dataModel을 이 뷰에서 쓰기위한 선언

    var body: some View {
        ZStack{
            ForEach(vmItem) { item in
                ZStack{
                    Rectangle().fill(.green).frame(width:100, height:100)
                    Text("New node")
                }.position(item.position)
                    .gesture(DragGesture()
                        .onChanged{ value in
                            //만약 아이템의 아이디와 누른 아이템의 아이디(노드)가 같은 경우, dataModel의 배열 위치와 index를 동일시 하고
                            //특정 인덱스(노드)의 위치는 dataModel의 위치에 값이 반영됨.
                            withAnimation(.linear){if let index = vmItem.firstIndex(where: {$0.id == item.id}){
                                vmItem[index].position = value.location
                            }
                                //쓰레기통 근처 범위는 x 위치 30~130 그리고 y위치 200~350사이임. 범위 내 있어야 true가 됨.(포지션과 로케이션 차이를 기억하기)
                                DraggingNearTheTrash = (30...130).contains(value.location.x) && (200...350).contains(value.location.y)
                            }

                        }.onEnded{value in
                            if DraggingNearTheTrash{
                                vmItem.removeAll{$0.id == item.id}
                            }
                            DraggingNearTheTrash = false
                        }
                    )
            }

            Button{//새로운 노드를 만드는 버튼
                vmItem.append(dataModel(name: "New Node", position: CGPointMake(100, 100)))
                //100,100 위치에 새로운 노드 생성+dataModel에 반영됨.

            }label:{
                Image(systemName:"doc.fill").font(.system(size: 20))
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottom)
            //애니메이션은 쓰레기통 근처에 갔을 때 반영.
            Image(systemName: DraggingNearTheTrash ? "trash.fill" : "trash").foregroundStyle(.white).background(DraggingNearTheTrash ? .pink : .black, in:Circle()).opacity(DraggingNearTheTrash ? 0.7: 1).scaleEffect(DraggingNearTheTrash ? 1.3: 1).position(x:45, y:275).animation(.spring, value: DraggingNearTheTrash)
        }
    }
}

#Preview {
    CollageByMyselfView()
}
