import XCTest
@testable import YouTubePlayerKit

final class YouTubePlayerHTMLTests: XCTestCase {
    
    func testInit() throws {
        let input = UUID().uuidString
        let youTubePlayerOptions = YouTubePlayer.Options(json: input)
        let youTubePlayerHTML = try YouTubePlayer.HTML(videoId: "1234", options: youTubePlayerOptions)
        XCTAssert(youTubePlayerHTML.contents.contains(input))
    }

    func testInitInsertsVideoIdIntoIFrame() throws {
      let input = UUID().uuidString
      let youTubePlayerOptions = YouTubePlayer.Options(json: input)
      let youTubePlayerHTML = try YouTubePlayer.HTML(
        videoId: "1234",
        options: youTubePlayerOptions,
        iFrameFeatures: "test-feature"
      )
      XCTAssert(youTubePlayerHTML.contents.contains("src=\"https://www.youtube.com/embed/1234?enablejsapi=1\""))
    }

    func testInitTakesIFrameFeatures() throws {
      let input = UUID().uuidString
      let youTubePlayerOptions = YouTubePlayer.Options(json: input)
      let youTubePlayerHTML = try YouTubePlayer.HTML(
        videoId: "1234",
        options: youTubePlayerOptions,
        iFrameFeatures: "test-feature"
      )
      XCTAssert(youTubePlayerHTML.contents.contains("allow=\"test-feature\""))
    }

    func testUnavailableResourceError() {
        XCTAssertThrowsError(
            try YouTubePlayer.HTML(
                videoId: "1234",
                options: .init(json: .init()),
                resource: .init(
                    fileName: "UnavailableResource",
                    fileExtension: "unavailable"
                )
            )
        )
    }
    
}
