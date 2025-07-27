//
//  GetAppTabsUseCaseTests.swift
//  OkaroneTests
//
//  Created by Sourav on 15/5/25.
//

import Testing
@testable import Okarone

struct GetAppTabsUseCaseTests {
    
    @Test func testExecuteReturnsExpectedTabs() async throws {
        // Given
        let useCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl()
        
        // When
        let result = useCase.execute()
        
        // Then
        #expect(result.count == 3)
        #expect(result.contains(.bookstoreSearch))
        #expect(result.contains(.okaroneFeed))
        #expect(result.contains(.readForToday))
    }
    
    @Test func testExecuteReturnsTabsInCorrectOrder() async throws {
        // Given
        let useCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl()
        
        // When
        let result = useCase.execute()
        
        // Then
        #expect(result.count >= 3)
        #expect(result[0] == .bookstoreSearch)
        #expect(result[1] == .okaroneFeed)
        #expect(result[2] == .readForToday)
    }
    
    @Test func testExecuteReturnsValidAppTabInstances() async throws {
        // Given
        let useCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl()
        
        // When
        let result = useCase.execute()
        
        // Then
        for tab in result {
            #expect(!tab.label.isEmpty)
            #expect(!tab.systemImage.isEmpty)
        }
    }
    
    @Test func testExecuteReturnsUniqueTabs() async throws {
        // Given
        let useCase: GetAppTabsUseCase = GetAppTabsUseCaseImpl()
        
        // When
        let result = useCase.execute()
        
        // Then
        let uniqueTabs = Set(result)
        #expect(uniqueTabs.count == result.count)
    }
} 
