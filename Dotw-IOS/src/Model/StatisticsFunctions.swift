//
//  StatisticsFunctions.swift
//  Dotw-IOS
//
//  Created by Luis Santiago  on 11/13/17.
//  Copyright © 2017 Luis Santiago. All rights reserved.
//

import Foundation

struct StatisticFuntions{
    
    //The Mean(average) was calculated with the formula: ∑ = x
    func mean(collection : [Double])->Double{
        var accumalator :Double = 0;
        for number in collection {
            accumalator = number + accumalator;
        }
        return accumalator / Double(collection.count);
    }
    
    //The mean variation was calculated with the formula: Σ= |x-⨰|^2 / n
    func meanVariations(numbers : [Double])->Double{
        let mean = self.mean(collection: numbers);
        var acummulator : Double = 0;
        for number in numbers{
            acummulator += abs(pow(Double(number - mean), 2));
        }
        return sqrt(acummulator / Double(numbers.count));
    }
    
    func reduceDecimal (with number : Double)-> Double{
        return Double(round(number*1000)/1000);
    }
    
}
