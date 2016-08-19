//
//  ViewController.swift
//  MemoryDish
//
//  Created by Ray Fix @rayfix on 8/19/16.
//  Copyright © 2016 Neko Labs. See LICENSE.txt (CC2)
//

import UIKit

class Dish {
  let name: String
  init(name: String) {
    self.name = name
    print("🍽 Dish \(name) Init 🐥")
  }
  
  deinit {
    print("🍽 Dish \(name) Deinit ☠️")
  }
}

enum MenuItem: String {
  case toro, ebi, anago, uni, ikura, hamachi
}

typealias Action = ()->()

class Sushiya {
  var served = 0
  
  init() {
    print("🍣🍣🍣🍶 Sushiya Init 🐥")
  }
  
  deinit {
    print("🍣🍣🍣🍶 Sushiya Denit ☠️")
  }
  
  
  // LEAK!
  lazy var menu: [MenuItem: Action] = [
    .toro: {
      let dish = Dish(name: "Toro")
      self.serve(dish: dish)
    }
  ]
  
  // Correct
  //  lazy var menu: [MenuItem: Action] = [
  //    .toro: { [unowned self] in
  //      let dish = Dish(name: "Toro")
  //      self.serve(dish: dish)
  //    }
  //  ]

  func prepare(_ menuItem: MenuItem) {
    menu[menuItem]?()
  }

  private func serve(dish: Dish) {
    print("Now serving \(dish.name)")
    served += 1
  }

  // The below are different implementations of the serve() function
  // to be used with the correct version of the closure.
  
  // CRASH!
  //  private func serve(dish: Dish) {
  //   DispatchQueue.main.async { [unowned self] in
  //    print("Now serving \(dish.name)")
  //    self.served += 1
  //    }
  //  }
  
  // Extended lifetime: will properly execute
  //  private func serve(dish: Dish) {
  //   DispatchQueue.main.async {
  //    print("Now serving \(dish.name)")
  //    self.served += 1
  //    }
  //  }
  
  // Weak self, will not extend lifetime but will not crash or leak
  //  private func serve(dish: Dish) { [weak self] in
  //   DispatchQueue.main.async {
  //    print("Now serving \(dish.name)")
  //    self?.served += 1
  //    }
  //  }
  
  // Strong Weak Dance, will not extend lifetime but will not crash or leak
  //  private func serve(dish: Dish) {
  //    DispatchQueue.main.async { [weak self] in
  //      guard let strongSelf = self else {
  //        print("Cancelled \(dish.name)")
  //        return
  //      }
  //      print("Now serving \(dish.name)")
  //      strongSelf.served += 1
  //    }
  //  }
  
  }

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let sushiya = Sushiya()
    sushiya.prepare(.toro)

    
  }
}

