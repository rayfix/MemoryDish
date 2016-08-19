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

class Customer {
  let name: String
  private(set) var orders: [Order]
  
  func add(order: Order) {
    orders.append(order)
    order.customer = self
    print("💰 Order Added \(order.dish.name)")
  }
  
  init(name: String) {
    self.name = name
    self.orders = []
    print("🚶 Customer \(name) Init 🐥")
  }
  
  deinit {
    print("🚶 Customer \(name) Deinit ☠️")
  }
}

class Order {
  var customer: Customer?

  // OBSERVE LEAK with Memory Visualizer
  // NO Deinit ☠️ messages are printed
  
  // FIX THE LEAK BY ADDING WEAK HERE!
  // weak var customer: Customer?
  
  let dish: Dish
  init(dish: Dish) {
    self.dish = dish
    print("💸 Order \(dish.name) Init 🐥")
  }
  deinit {
    print("Order \(dish.name) Deinit ☠️")
  }
}

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let ray = Customer(name: "Ray")
    let saikoro = Dish(name: "Saikoro Steak")
    let order = Order(dish: saikoro)
    ray.add(order: order)
  }
}

