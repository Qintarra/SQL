-- Add new column **short_name** to the **manufacturer** table
ALTER TABLE manufacturer
ADD short_name CHAR;

-- Add new column **isActive** to the **person** table
ALTER TABLE person
ADD isActive BOOL;

-- Add new column **area** to the **supermarket** table
ALTER TABLE supermarket
ADD area DOUBLE;