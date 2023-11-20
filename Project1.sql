USE tuckerelectronics;

ALTER TABLE manager ADD PRIMARY KEY(ManagerID);
ALTER TABLE building ADD PRIMARY KEY(BuildingID(3));
ALTER TABLE building ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES manager(ManagerID);
ALTER TABLE room ADD CONSTRAINT pkc_room PRIMARY KEY (BuildingID(3), Room_Number);
ALTER TABLE building MODIFY BuildingID VARCHAR(3); 
ALTER TABLE inventory ADD CONSTRAINT pkc_inventory PRIMARY KEY (ItemID,BuildingID(3),Room_Number);
ALTER TABLE item ADD PRIMARY KEY(ItemID);
ALTER TABLE vendors ADD PRIMARY KEY(VendorID);
ALTER TABLE item ADD CONSTRAINT FK_Vendor FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID);
ALTER TABLE inventorypurchase ADD constraint pkc_inventorypurchase PRIMARY KEY (ItemID,OrderID);
ALTER TABLE tuckerelectronics.order ADD PRIMARY KEY (OrderID);

-- 1.	Which items are currently on order and from what vendor? Include the vendor name and location. 
SELECT item.itemID, item.vendorID, Vendor_Name, buildingID, item_Quantity_On_Order
FROM inventory, item, vendors
WHERE item.itemID = inventory.itemID
AND item.vendorID = vendors.vendorID;
-- 2.	What is the list of inventory (items), along with the location (building and room) and the quantity on hand of each. 
SELECT itemID, buildingID, item_quantity_on_hand, room_number
FROM inventory;
-- 3.	What is the aggregated total inventory of each item in each room of each building? Include each item number and name, along with its total.

SELECT count(inventory.itemID), item_name, buildingID, Room_number
FROM inventory, item
WHERE item.itemID = inventory.itemID
GROUP BY item_name, buildingID, Room_number;
-- 4.	What is the manager’s name and phone number of each building and the products stored in that building? 
SELECT managerFname, managerMI, managerLname, building_phone_number
FROM manager, building
WHERE manager.managerID = building.managerID;

-- 5.	What is the aggregated total inventory of all items in all buildings by vendor name? 

-- 6.	What items have purchase orders from what vendors with what amounts?
SELECT inventorypurchase.itemID, orderID, vendor_name, item_quantity_on_order
FROM inventorypurchase, item, vendors
WHERE item.itemID = inventorypurchase.ItemID
AND vendors.vendorID = item.vendorID;
-- 7.	Write at least one more query of your choosing. It must include an average aggregate calculation of some type.
SELECT avg(item_cost) as 'AverageItemCost'
FROM item;

-- 8.	Write at least one more query of your choosing. It must include a subquery.
SELECT itemID, item_name
FROM item
WHERE item.item_name IN (select distinct item_name FROM item);



/*
ALTER TABLE vendor ADD PRIMARY KEY(Vendor_ID); 

If a PK contains text data, you must define the length of the primary key, as shown below in the text data of the building code (e.g., NTC) for the building table. 
ALTER TABLE building ADD PRIMARY KEY(Building_Code(3)); 

If the PK is composite, refer to the example below for the room table. Notice the ADD CONSTRAINT statement, where we give the constraint a name (pkc_room) along with identifying the two fields that comprise the primary key.
ALTER TABLE building_room ADD CONSTRAINT pkc_room PRIMARY KEY (BuildingCode(3), Room_Number); 

If you have a table with a PK that has a data type of TEXT, you must modify (alter) the table again to change the data type from TEXT to VARCHAR and identify the appropriate length for that field. Below is an example. The VARCHAR (variable data type with a fixed length of three (instead of the variable length TEXT data type)) will assist as you build the FK in the next steps.
ALTER TABLE building MODIFY Building_Code VARCHAR(3); 

Create the foreign keys to establish the one-to-many (1:M) relationships between the tables in your ERD. See the examples below. Notice the use of a constraint to make the FK. 
ALTER TABLE item ADD CONSTRAINT FK_Vendor_code FOREIGN KEY (Vendor_Code) REFERENCES vendor(Vendor_Code); 

If you need to build a foreign keys to connect to a table with a composite PK,  see the example below. 
ALTER TABLE inventory 
ADD CONSTRAINT FK_Inventory_RoomNumber FOREIGN KEY (BuildingCode, RoomNumber) REFERENCES building_room(BuildingCode, RoomNumber);

*/