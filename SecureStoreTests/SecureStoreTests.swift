//
//  SecureStoreTests.swift
//  SecureStoreTests
//
//  Created by Serhii Syrotynin on 9/6/19.
//  Copyright © 2019 Serhii Syrotynin. All rights reserved.
//

import XCTest
@testable import SecureStore

class SecureStoreTests: XCTestCase {
	var secureStoreWithGenericPwd: SecureStore!

	override func setUp() {
		super.setUp()

		let genericPwdQueryable = GenericPasswordQueryable(service: "MyService")
		secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
	}

	override func tearDown() {
		try? secureStoreWithGenericPwd.removeAllValues()
		super.tearDown()
	}

	func testSaveGenericPassword() {
		do {
			try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
		} catch (let e) {
			XCTFail("Saving generic password failed with \(e.localizedDescription).")
		}
	}

	func testReadGenericPassword() {
		do {
			try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
			let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
			XCTAssertEqual("pwd_1234", password)
		} catch (let e) {
			XCTFail("Reading generic password failed with \(e.localizedDescription).")
		}
	}

	func testUpdateGenericPassword() {
		do {
			try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
			try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
			let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
			XCTAssertEqual("pwd_1235", password)
		} catch (let e) {
			XCTFail("Updating generic password failed with \(e.localizedDescription).")
		}
	}

	func testRemoveGenericPassword() {
		do {
			try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
			try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
			XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
		} catch (let e) {
			XCTFail("Saving generic password failed with \(e.localizedDescription).")
		}
	}

	func testRemoveAllGenericPasswords() {
		do {
			try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
			try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
			try secureStoreWithGenericPwd.removeAllValues()
			XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
			XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
		} catch (let e) {
			XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
		}
	}
}

