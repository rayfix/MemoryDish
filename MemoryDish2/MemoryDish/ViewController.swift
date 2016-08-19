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
  
  func add(dish: Dish) {
    let order = Order(dish: dish, customer: self)
    orders.append(order)
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
  let customer: Customer

  // OBSERVE LEAK with Memory Visualizer
  // NO Deinit ☠️ messages are printed
  
  // FIX THE LEAK BY ADDING UNOWNED HERE!
  // unowned let customer: Customer
  
  let dish: Dish
  init(dish: Dish, customer: Customer) {
    self.dish = dish
    self.customer = customer
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
    ray.add(dish: saikoro)
  }
}

