//
//  OrderListModel+CoreDataProperties.swift
//  E-commerce
//
//  Created by Mina on 08/03/2023.
//
//

import Foundation
import CoreData


extension OrderListModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderListModel> {
        return NSFetchRequest<OrderListModel>(entityName: "OrderListModel")
    }

    @NSManaged public var itemID: Int64
    @NSManaged public var itemPrice: String?
    @NSManaged public var itemQuantity: Int64
    @NSManaged public var userID: Int64
    @NSManaged public var itemImage: String?
    @NSManaged public var itemName: String?

}

extension OrderListModel : Identifiable {

}
