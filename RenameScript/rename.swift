//
//  rename.swift
//
//  Created by Roster on 2019/12/31.
//  Copyright © 2019 ackirin. All rights reserved.
//

import Foundation

let ignordFiles: Set<String> = [".DS_Store", "rename.swift"]

/// 创建文件夹(name/iOS)
func createFolder(_ name: String, local path: String) -> String {
    
    let desPath = path + "/" + name + "/" + "iOS"
    let fileManager = FileManager.default
    try? fileManager.createDirectory(atPath: desPath, withIntermediateDirectories: true, attributes: nil)
    print("\(#function) \(desPath)")
    return desPath
}

/// 移除文件夹
func removeFolder(_ path: String) {
    
    let fileManager = FileManager.default
    try? fileManager.removeItem(atPath: path)
    print("\(#function) \(path)")
}

/// 压缩文件/文件夹
func kekaZip(_ path: String) {
    
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = ["/Applications/Keka.app/Contents/MacOS/Keka", path]
//    process.arguments = ["ls"]
    process.launch()
    process.waitUntilExit()
    print("\(#function) \(process.terminationStatus)")
}

func test() {
    
    let fileManager = FileManager.default
    let currentDirPath = fileManager.currentDirectoryPath
    print("\(currentDirPath)")
    let paths = fileManager.subpaths(atPath: currentDirPath) ?? []
    
    
    let numberFormatter = NumberFormatter()
    numberFormatter.minimumIntegerDigits = 3
    
    var beigin = ""
    print("请输入文件夹名称, Ex: S006")
    if let inputValue = readLine() {
        beigin = inputValue
    }
    
    // 创建文件夹
    let desDirPath = createFolder(beigin, local: currentDirPath)
    
    // Move files
    for (index, path) in paths.sorted().enumerated() {
        
        if ignordFiles.contains(path) {
            continue
        }
        if !path.hasSuffix(".png") {
            continue
        }
        print("\(path)")
        let filePath = currentDirPath + "/" + path
        let newFilePath = desDirPath + "/" + beigin + (numberFormatter.string(from: NSNumber(value: index)) ?? "") + ".png"
        print("filePath: \(filePath)")
        print("newFilePath: \(newFilePath)")
        try? fileManager.moveItem(atPath: filePath, toPath: newFilePath)
    }
    
    // 压缩
    let willZipPath = currentDirPath + "/" + beigin
    kekaZip(willZipPath)
    
    // 移除文件夹
    removeFolder(willZipPath)
}


test()



