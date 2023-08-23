⚠️ 진행 중

# SearchAPI_Toy

![원기옥](https://media.tenor.com/E7fROB_zqFAAAAAC/%EC%9B%90%EA%B8%B0%EC%98%A5.gif)
<br/>

~~조금씩 조금씩~~
<br/>

## 소개

![ㅇㅇ](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/vclip%EA%B2%80%EC%83%89.gif?raw=true) ![카드뷰](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/%EC%B9%B4%EB%93%9C%EB%B7%B0.gif?raw=true)
<br/>

카카오의 Open API 통한 Toy Project, 검색 관련 모든 api와 파라미터를 사용
<br/>

**개발환경:** Xcode 14.2, iOS 15.0, SwiftUI, Combine, CoreData
<br/>

**개발언어:** Swift
<br/>

**api:** [Daum 검색](https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide)
<br/>

![로딩](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%A1%9C%EB%94%A9.gif?raw=true) ![메인](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/main.gif?raw=true)
<br/>

런치스크린 후 하단 탭바로 각 검색페이지 구분
<br/>

<details>
<summary>무한스크롤</summary>

**이미지 로딩을 Async 처리, 로딩 중일 때 구분**
<br/>

1. 웹문서
   ![웹문서](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%20%EC%9B%B9.gif?raw=true)
   <br/>

2. 이미지
   ![이미지](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/무한스크롤.gif?raw=true)
   <br/>

3. 동영상
   ![동영상](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%EB%8F%99%EC%98%81%EC%83%81.gif?raw=true)
   <br/>

4. 책
   ![책](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%EB%B6%81.gif?raw=true)
   <br/>

5. 카페
   ![카페](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%EC%B9%B4%ED%8E%98.gif?raw=true)
   <br/>

6. 블로그
   ![블로그](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%EB%B8%94%EB%A1%9C%EA%B7%B8.gif?raw=true)
   <br/>

<details>
<summary>검색</summary>

1. 검색 했던 검색어 기록
   ![검색기록](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/검색기록.gif?raw=true)
   <br/>

2. 검색 조건 설정 가능
   ![검색](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EA%B2%80%EC%83%89%EC%A1%B0%EA%B1%B4%20%EC%A0%81%EC%9A%A9_%ED%8C%8C%EB%9D%BC%EB%AF%B8%ED%84%B0%20%EC%A0%81%EC%9A%A9.gif?raw=true)
   <br/>

3. 검색어 기록 삭제 가능
   ![기록삭제](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/검색기록_삭제.gif?raw=true)
   <br/>

4. 검색 게시물을 보던 중에 새롭게 검색 조건 설정 가능
   ![검색조건](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/검색조건%20변경.gif?raw=true)
   <br/>

</details>

<details>

<summary>뷰 마다 게시물의 차이</summary>

1. 이미지 -> popup 뷰 커스텀, 원본 링크로 이동(WebView)링크
   ![1](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/img%EA%B2%80%EC%83%89.gif?raw=true)
   <br/>

2. 동영상 -> 원본 링크로 이동(WebView)
   ![2](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/webview1.gif?raw=true)
   <br/>

3. 나머지 -> Card뷰 처리 게시물, 원본 링크로 이동(WebView)
   ![3](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/cafe%EA%B2%80%EC%83%89.gif?raw=true)
   <br/>

   ![4](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/webview2.gif?raw=true)
   <br/>

</details>

## 각 검색페이지 상세 설명

### 1. 웹문서 검색

![web](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/web검색.gif?raw=true) ![웡](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/%EA%B8%B0%EB%A1%9D/%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4%20%EC%9B%B9.gif?raw=true)
<br/>

<details>
<summary>검색어를 입력 받으면 api호출을 통해 data를 받아와 무한스크롤로 구현</summary>

```swift
// in WebSearchModel.swift
// MARK: - WebResponse
struct WebResponse: Codable {
    let meta: WebMeta?
    var documents: [WebDocument]
}

// MARK: - WebDocument
struct WebDocument: Codable, Identifiable {
    let id = UUID()
    var datetime, contents, title: String
    let url: String
}

// 생략
// ..
// ..
// ..

// MARK: - WebSearchManger
// DataPublisher로 받아온 data를 WebSearchModel 형태로 디코딩 및 파싱용
final class WebSearchManger {
    // 싱글톤 적용
    static let shared: WebSearchManger = .init()

    // MARK: - WebDocumentPublisher
    func WebSearchPublisher(dataPublisher: AnyPublisher<Data, Error>) ->  AnyPublisher<WebResponse, Error> {
        let responsePublisher = dataPublisher
        // 디코딩
            .decode(type: WebResponse.self, decoder: JSONDecoder())
        // WebSearch 형태로 결과 쪼개기
            .map { response in
                var streamedResponse = response
                streamedResponse.documents = response.documents.map { document in
                    var streamedDocument = document
                    streamedDocument.title = streamedDocument.title.stripHTMLTags()
                    streamedDocument.contents = streamedDocument.contents.stripHTMLTags()
                    streamedDocument.datetime = streamedDocument.datetime.fomatDateTime()!
                    return streamedDocument // 테그 제거, 날짜 표기 변경 완료
                }
                return streamedResponse // html 테그 띤 Response를 반환
            }
            .eraseToAnyPublisher()
        return responsePublisher
    }
}
```

<br/>

API로 받아올 모델 정의 및 API를 사용하도록 파싱
<br/>

```swift
// in WebSearchViewModel.swift
// MARK: - fetchWebSearchData
// 뷰모델에서 검색어에 관련된 WebSearchData를 가져오는 메소드
func fetchWebSearchData(query: String) {
  // 생략
  // ..
  // ..

  DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
    guard let self = self else { return }
      // 받아온 data를 WebSearch에 맞게 끔 디코딩 및 파싱
      WebSearchManger.shared
        .WebSearchPublisher(dataPublisher: dataPublisher)
//                .receive(on: DispatchQueue.main) // 어차피 DispatchQueue.main.asyncAfter을 사용하므로
        .sink(receiveCompletion: { [weak self] completion in
            self?.webOnReceive(completion)
        }, receiveValue: { [weak self] response in
            self?.webOnReceive(response)
        })
        .store(in: &self.cancellables)
    }
}

// 생략
// ..
// ..
// MARK: - FetchDataAtScroll
// 스크롤로 데이터를 내릴대 호출
func FetchDataAtScroll() {
  // 생략
  // ..

  // 이어서 가져오기 때문
  searchParam.page = self.currentPage + 1

  // 생략
  // ...
  // ...

  DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
    guard let self = self else { return }
          // fetchWebSearchData와 동일한 로직이므로
          // 생략
          // ...
    }
}
```

<br/>

무한스크롤로 게시물을 추가로 불러와야 **Loding** 표시
<br/>

</details>

<details>
<summary>게시물을 클릭시 원본 링크로 이동</summary>
TODO
</details>

#### 2. 이미지 검색

![img](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/img검색.gif?raw=true)
<br/>

<details>
<summary>이미지 게시물 표현</summary>
TODO
</details>

<details>
<summary>이미지 게시물 클릭(actionView 커스텀)</summary>
TODO
</details>

#### 4. 동영상 검색

![vclip](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/vclip검색.gif?raw=true)

<details>
<summary>동영상 게시물 표현</summary>
TODO
</details>

<details>
<summary>동영상 클릭</summary>
TODO
</details>

#### 5. 책 검색

![book](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/book검색.gif?raw=true)
<br/>

<details>
<summary> 책 게시물 표현</summary>
TODO
</details>

#### 6. 카페/블로그 검색

![cafe](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/cafe검색.gif?raw=true)![blog](https://github.com/BOLTB0X/SearchAPI_Toy/blob/main/gif/01/blog검색.gif?raw=true)
<br/>

<details>
<summary>카페/블로그 게시물 표현</summary>
TODO
</details>

## 참고

- API 관련

  - [api 호출 방법](https://donghoon.io/blog/swift_image_search/) +[api 호출 관련](https://rldd.tistory.com/215)

- 무한 스크롤 관련

  - [V8tr/InfiniteListSwiftU](https://github.com/V8tr/InfiniteListSwiftUI)

  - [codekodo.tistory](https://codekodo.tistory.com/207)

- 팝업 관련

  - [custom PopUp](https://github.com/SnowLukin/CustomPopUp)

- 애니메이션

  - [KeatoonMask](https://github.com/KeatoonMask/SwiftUI-Animation/tree/master)

  - [기본 애니메이션](https://80000coding.oopy.io/bfcbea75-767f-4a9a-87c3-0883a97115bc)

- SwiftUI 관련

  - [ProgressView 관련](https://seons-dev.tistory.com/entry/SwiftUI-ProgressView-작업-진행률)

  - [Redacted 관련](https://seons-dev.tistory.com/entry/SwiftUI-Redacted)

  - [weak self 관련](https://ios-development.tistory.com/926)

  - [tabView 관련](https://seons-dev.tistory.com/entry/SwiftUI-TabView)

  - [Picker 관련](https://www.hohyeonmoon.com/blog/swiftui-tutorial-picker/)

  - [WebView](https://seons-dev.tistory.com/entry/SwiftUI-WebView-%EC%83%9D%EC%84%B1%EC%BD%94%EB%93%9C)

  - [검색 뷰 관련](https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data)

  - [런치스크린](https://velog.io/@jyw3927/SwiftUI-Launch-Screen-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-Gradient-Animation)

  - [카드 뷰](https://www.appcoda.com/swiftui-card-view/)

- CoreData

  - [avanderlee](https://www.avanderlee.com/swift/persistent-history-tracking-core-data/)

  - [입문](https://velog.io/@nala/iOS-SwiftUI%EC%97%90%EC%84%9C-CoreData-%EC%8D%A8%EB%B3%B4%EA%B8%B0)

  - [김종권의 iOS](https://ios-development.tistory.com/1162)

  - [참고 티스토리](https://growingsaja.tistory.com/791)
