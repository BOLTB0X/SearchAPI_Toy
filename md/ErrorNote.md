# 에러 노트

![아차](https://4.bp.blogspot.com/-4_gE3ixgf4M/XDa_-U4jEtI/AAAAAAAAEUA/sxvRH_KRapkhPbXF3OGZJwnqkjhnHFK0ACLcBGAs/s1600/4.gif)
<br/>

의미있던 버그들 수정한 것들 기록
<br/>

## 01

### 검색 기록 에러

![검색](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EB%AC%B4%ED%95%9C%EA%B2%80%EC%83%89%ED%98%B8%EC%B6%9C%20%EC%97%90%EB%9F%AC.gif?raw=true)
<br/>

삭제 버튼을 누르지 않고 그냥 리스트를 클릭하면 없어짐
<br/>

**해결**
<br/>

```swift
Button(action: {
    withAnimation {
        searchHistory.searchHistory.removeAll(where: { $0.id == history.id })
        CoreDataManager.shared.deleteSearchHistory(searchHistory: history)
}
}) {
    Image(systemName: "x.circle")
        .resizable()
        .foregroundColor(.blue)
        .frame(width: 15, height: 15)
    }
    .buttonStyle(BorderlessButtonStyle()
)
```

기존 DefaultButtonStyle으로 하면 이미지 버튼이 포함된 셀을 클릭하면 리스트셀 내 버튼을 클릭하지 않아도 클릭했다고 인식해버리므로 버튼 스타일 변경으로 해결
<br/>

### 무한 데이터 호출

![영상](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D%EC%82%AD%EC%A0%9C%20%EC%97%90%EB%9F%AC.gif?raw=true)

스크롤을 내리지 않아도 계속 데이터 호출
<br/>

**해결**
<br/>

```swift
// 중략
ScrollView {
    LazyVStack(alignment: .leading, spacing: 10) {
        ForEach(webViewModel.searchWeb, id: \.id) { document in
            // 중략
        }
        .padding(5)
    }
}
```

VStack에서 LazyVStack으로 해결
<br/>
