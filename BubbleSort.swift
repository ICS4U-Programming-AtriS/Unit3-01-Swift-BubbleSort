//
//  BubbleSort.swift
//
//  Created by Atri Sarker
//  Created on 2025-11-09
//  Version 1.0
//  Copyright (c) 2025 Atri Sarker. All rights reserved.
//
//  Bubble Sort.
import Foundation

// Constant for the file path of the input file.
let inputFilePath = "./input.txt"
// Constant for the file path of the output file.
let outputFilePath = "./output.txt"

// Bubble Sort Function
// Sorts an array of integers using the bubble sort algorithm.
func bubbleSort(_ array: [Int]) -> [Int] {
    var arr = array
    // Iterate over maxBound
    // Had to use stride() 
    // because ((arr.count - 1) ... 0).reversed() didn't work
    for maxBound in stride(from: arr.count - 1, through: 0, by: -1) {
        // Flag for early completions
        var solved = true
        // Iterate over unsorted portion
        for index in 0 ..< maxBound {
            // Check if the current element is greater than the next element
            if arr[index] > arr[index + 1] {
                // If so, perform a swap
                let temp = arr[index]
                arr[index] = arr[index + 1]
                arr[index + 1] = temp
                // Set flag to false
                solved = false
            }
        }
        // If no swaps were made, the array is sorted
        if solved {
            break
        }
    }
    // Return the sorted array
    return arr
}

// Access the input file
guard let inputFile = FileHandle(forReadingAtPath: inputFilePath) else {
    print("CANNOT OPEN INPUT FILE")
    exit(1)
}

// Access the output file for writing
guard let outputFile = FileHandle(forWritingAtPath: outputFilePath) else {
    print("CANNOT OPEN OUTPUT FILE FOR WRITING")
    exit(1)
}

// Helper function for writing data
func writeToOutputFile(_ text: String) {
    if let data = text.data(using: .utf8) {
        outputFile.write(data)
    } else {
        print("Error: WRITING FAILED")
    }
}

// Read the contents of the input file
let inputData = inputFile.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("CANNOT CONVERT FILE DATA TO A STRING")
    exit(1)
}

// Create a list of all available lines
let listOfLines = inputString.components(separatedBy: .newlines)

// Loop through all the lines in the list
for line in listOfLines {
    // Check if the line is empty
    if line == "" {
        // If so, write an error message and continue
        writeToOutputFile("Error: No integers were found on this line.\n")
        continue
    }
    // Split the line
    let stringArr = line.split(separator: " ")
    // Convert String array into an int array
    var intArr = [Int]()
    for str in stringArr {
        if let num = Int(str) {
            intArr.append(num)
        }
    }
    // Print Array before Sorting
    print("Before: \(intArr)")
    // Sort the array
    let sortedArr = bubbleSort(intArr)
    // Print Array after Sorting
    print("After: \(sortedArr)")

    // Write the sorted array to the output file
    for num in sortedArr {
        writeToOutputFile("\(num) ")
    }
    // Write a newline
    writeToOutputFile("\n")
}




